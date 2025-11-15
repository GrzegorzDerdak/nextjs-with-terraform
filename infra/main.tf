# filename: infra/main.tf

# Configure the Vercel provider using the required_providers stanza.
# You may optionally use a version directive to prevent breaking
# changes occurring unannounced.
terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 4.0.0"
    }
  }
}

provider "vercel" {
  # Or omit this for the api_token to be read
  # from the VERCEL_API_TOKEN environment variable
  api_token = var.vercel_api_token

  # Optional, team name for all resources
  # Can be found in Vercel dashboard URL when switching teams
  # https://vercel.com/account/settings
  team = "{{your-team-id}}"
}

resource "vercel_project" "nextjs_with_terraform" {
  # Vercel Project name (also used as subdomain name)
  # Example: my-nextjs-app
  name = "{{your-project-name}}"

  # Framework preset, in our case nextjs
  framework = "nextjs"

  # Used node version, must be one of the supported versions by Vercel
  node_version = "22.x"

  # You can specify custom build and development commands
  # build_command = "npm run build"

  # Directory where the project is located
  # Useful when the project is in a monorepo
  # root_directory = "apps/web"

  # Link to the Git repository
  git_repository = {
    type = "github"
    # Example:
    # repo = "JohnDoe/my-nextjs-app"
    repo = "{{your-github-username}}/{{your-project-name}}"
  }
}

resource "vercel_project_environment_variable" "example_env_var" {
  project_id = vercel_project.nextjs_with_terraform.id
  key        = "NEXT_PUBLIC_EXAMPLE_ENV_VAR"
  value      = "MyExampleValue"
  target     = ["production", "preview", "development"]

  # To make it sensitive, uncomment the following line
  # sensitive = true

  # Optionally, provide the comment of the environment variable
  # comment = "An example environment variable"

  # If you want to specify a git branch, use the following argument
  # Only if target is set to "preview"
  # git_branch = "main"
}

# Add another environment variable to the project.
# This time will do a different values for different environments. 
# One for preview and one for production.
resource "vercel_project_environment_variable" "stripe_secret_test" {
  project_id = vercel_project.nextjs_with_terraform.id
  key        = "STRIPE_SECRET_KEY"
  value      = var.stripe_secret_test
  target     = ["preview"]

  # We want this one to be sensitive
  sensitive = true

  # Optionally, provide the description of the environment variable
  comment = "A secret key for Stripe in preview environment used in checkout."

  # If you want to specify a git branch, use the following argument
  # Only if target is set to "preview"
  # git_branch = "main"
}
resource "vercel_project_environment_variable" "stripe_secret_live" {
  project_id = vercel_project.nextjs_with_terraform.id
  key        = "STRIPE_SECRET_KEY"
  value      = var.stripe_secret_live
  target     = ["production"]

  # We want this one to be sensitive
  sensitive = true

  # Optionally, provide the description of the environment variable
  comment = "A secret key for Stripe in production environment used in checkout."

  # If you want to target a specific git branch, use the following argument:
  # Note: works only if target is set to "preview"
  # git_branch = "main"
}

# Instead of creating multiple resources for multiple environment variables,
# you can use the vercel_project_environment_variables resource to create
# multiple environment variables at once.
resource "vercel_project_environment_variables" "sentry_variables" {
  project_id = vercel_project.nextjs_with_terraform.id
  variables = [
    {
      key    = "SENTRY_DSN"
      value  = "https://examplePublicKey@o0.ingest.sentry.io/XXXXYYYY"
      target = ["preview", "production"]
    },
    {
      key    = "SENTRY_ENVIRONMENT"
      value  = "preview"
      target = ["preview"]
    },

    {
      key    = "SENTRY_ENVIRONMENT"
      value  = "production"
      target = ["production"]
    },
  ]
}

# Dynamically create environment variables from the env_vars variable
# defined in variables.tf and populated in terraform.tfvars
resource "vercel_project_environment_variable" "dynamic_env_vars" {
  for_each   = var.env_vars
  project_id = vercel_project.nextjs_with_terraform.id
  key        = each.key
  value      = each.value.value
  target     = each.value.target
  comment    = lookup(each.value, "comment", null)
  sensitive  = lookup(each.value, "sensitive", false)
}


# Project domain
# By default, every Vercel project has a domain
# in the format: <project-name>.vercel.app
# You can specify additional domains if needed.
resource "vercel_project_domain" "example" {
  project_id = vercel_project.nextjs_with_terraform.id
  domain     = "another-subdomain-for-my-project.vercel.app"
}
