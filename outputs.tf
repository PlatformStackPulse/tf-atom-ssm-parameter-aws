output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "The name (id) of the SSM parameter."
  value       = try(aws_ssm_parameter.this[0].id, null)
}

output "arn" {
  description = "The ARN of the SSM parameter."
  value       = try(aws_ssm_parameter.this[0].arn, null)
}

output "name" {
  description = "The name (path) of the SSM parameter."
  value       = try(aws_ssm_parameter.this[0].name, null)
}

output "version" {
  description = "The version of the SSM parameter."
  value       = try(aws_ssm_parameter.this[0].version, null)
}
