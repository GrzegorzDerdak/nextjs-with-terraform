# Next.js with Terraform on Vercel

A production-ready Next.js project demonstrating Infrastructure as Code (IaC) deployment to Vercel using Terraform. This repository serves as a companion to the blog post: **[Setting Up Terraform with Vercel: A Developer's Guide](https://derdak.dev/blog/setting-up-terraform-with-vercel?utm_source=nextjs-terraform-repo&utm_medium=github/)**.

## 📖 About This Project

This project demonstrates how to manage Vercel deployments programmatically using Terraform instead of manual dashboard configuration. Perfect for teams who need:

- ✅ Version-controlled infrastructure
- ✅ Reproducible deployments across environments
- ✅ Automated environment variable management
- ✅ Infrastructure change tracking through pull requests

## 🚀 Quick Start

### Prerequisites

- Node.js 22.x or higher
- [Terraform](https://developer.hashicorp.com/terraform/install) installed
- A [Vercel account](https://vercel.com)
- A [Vercel API token](https://vercel.com/account/tokens)

### Local Development

1. Clone the repository:

```bash
git clone https://github.com/GrzegorzDerdak/nextjs-with-terraform.git
cd nextjs-with-terraform
```

2. Install dependencies:

```bash
pnpm install
```

3. Run the development server:

```bash
pnpm run dev
```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

## 🏗️ Infrastructure Setup with Terraform

### Initial Configuration

1. Navigate to the infrastructure directory:

```bash
cd infra
```

2. Create a `terraform.tfvars` file (this file is gitignored):

```hcl
vercel_api_token = "your-vercel-api-token-here"
```

3. Initialize Terraform:

```bash
terraform init
```

4. Review the planned changes:

```bash
terraform plan
```

5. Apply the infrastructure:

```bash
terraform apply
```

### Project Structure

```
nextjs-with-terraform/
├── infra/                   # Terraform configuration
│   ├── main.tf              # Vercel resources (project, env vars, domains)
│   ├── variables.tf         # Variable definitions
│   └── terraform.tfvars     # Variable values (gitignored)
├── src/
│   └── app/                 # Next.js app directory
├── public/
└── package.json
```

## 🔧 Infrastructure Components

The Terraform configuration in `/infra` manages:

- **Vercel Project**: Automated project creation with Git integration
- **Environment Variables**: Dynamic configuration for multiple environments
- **Custom Domains**: DNS and SSL management (optional)
- **Build Settings**: Framework detection and Node.js version

### Example: Adding Environment Variables

Edit `infra/main.tf`:

```hcl
resource "vercel_project_environment_variable" "api_url" {
  project_id = vercel_project.nextjs_with_terraform.id
  key        = "NEXT_PUBLIC_API_URL"
  value      = "https://api.example.com"
  target     = ["production", "preview", "development"]
}
```

Then apply:

```bash
cd infra
terraform apply
```

## 📚 Learn More

### About This Project

- **Blog Post**: [Managing Vercel with Terraform: Infrastructure as Code for Modern Deployments](https://derdak.dev/blog/terraform-vercel-setup)
- **Vercel Terraform Provider**: [Official Documentation](https://registry.terraform.io/providers/vercel/vercel/latest/docs)

### Next.js Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Learn Next.js](https://nextjs.org/learn)
- [Next.js GitHub Repository](https://github.com/vercel/next.js)

## 🛡️ Best Practices

This project demonstrates:

- **Secure Secrets Management**: API tokens in gitignored `.tfvars` files
- **Environment Separation**: Different configs for preview/production
- **Infrastructure Versioning**: All changes tracked in Git
- **Team Collaboration**: Infrastructure changes through pull requests

## 📝 Common Commands

```bash
# Development
pnpm run dev          # Start dev server
pnpm run build        # Build for production
pnpm run lint         # Run ESLint

# Infrastructure
cd infra
terraform init       # Initialize Terraform
terraform plan       # Preview changes
terraform apply      # Apply changes
terraform destroy    # Tear down infrastructure
terraform fmt        # Format .tf files
```

## 🤝 Contributing

This is a demonstration project, but suggestions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👤 Author

**Grzegorz Derdak**

- Website: [derdak.dev](https://derdak.dev)
- GitHub: [@GrzegorzDerdak](https://github.com/GrzegorzDerdak)
- LinkedIn: [Connect with me](https://www.linkedin.com/in/grzegorzderdak)

---

Built with ❤️ using Next.js and managed with Terraform
