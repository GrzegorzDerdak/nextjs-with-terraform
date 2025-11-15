variable "vercel_api_token" {
  type        = string
  description = "Vercel API Token"
  sensitive   = true
}

variable "stripe_secret_test" {
  type        = string
  description = "Stripe secret key for dev/qa environments."
  sensitive   = true
}


variable "stripe_secret_live" {
  type        = string
  description = "Stripe secret key for live environments."
  sensitive   = true
}

variable "sentry_dsn" {
  type        = string
  description = "Sentry DSN for error tracking."
}

# Map of dynamic environment variables to set in Vercel project
variable "env_vars" {
  type = map(object({
    value     = string
    target    = list(string)
    comment   = optional(string)
    sensitive = optional(bool, false)
  }))
  description = "Map of environment variables to set in Vercel project"
}
