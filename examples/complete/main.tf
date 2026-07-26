# -----------------------------------------------------------------------------
# Complete example: tf-atom-ssm-parameter-aws
#
#   terraform init
#   terraform plan
#
# Requires valid AWS credentials for a real apply.
# -----------------------------------------------------------------------------

provider "aws" {
  region = "eu-west-1"
}

module "ssm_parameter" {
  source = "../../"

  namespace   = "eg"
  environment = "dev"
  stage       = "app"
  name        = "database-url"

  description = "Connection string for the application database."
  type        = "SecureString"
  tier        = "Standard"
  value       = "postgres://user:pass@db.example.com:5432/app"

  tags = {
    Team = "platform"
  }
}

output "parameter_arn" {
  description = "ARN of the created SSM parameter."
  value       = module.ssm_parameter.arn
}

output "parameter_name" {
  description = "Name of the created SSM parameter."
  value       = module.ssm_parameter.name
}
