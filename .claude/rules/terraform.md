# Terraform Rules

## State Management

- Never commit `.tfstate` files to version control
- Use remote state backend (S3 + DynamoDB for locking)
- Enable state file encryption

## File Organization

```text
infra/
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
├── modules/
│   ├── vpc/
│   ├── ecs/
│   └── rds/
├── main.tf
├── variables.tf
├── outputs.tf
└── versions.tf
```

## Workflow

1. `terraform init` - Initialize working directory
2. `terraform fmt` - Format code
3. `terraform validate` - Validate configuration
4. `terraform plan` - Preview changes
5. `terraform apply` - Apply changes (after review)

## Best Practices

- Always run `terraform plan` before `apply`
- Use variables for environment-specific values
- Use modules for reusable components
- Pin provider and module versions
- Use `terraform fmt` before committing

## Security

- No hardcoded credentials in `.tf` files
- Use `sensitive = true` for secret variables
- Store secrets in SSM Parameter Store or Secrets Manager
- Reference secrets using `data` sources

## Naming Conventions

```hcl
# Resources: <provider>_<resource>_<name>
resource "aws_s3_bucket" "app_assets" {}

# Variables: descriptive, snake_case
variable "environment_name" {}

# Outputs: descriptive, snake_case
output "database_endpoint" {}
```

## Never Do

- Edit `.tfstate` files manually
- Run `apply` without reviewing `plan`
- Hardcode credentials or secrets
- Skip `terraform fmt`
