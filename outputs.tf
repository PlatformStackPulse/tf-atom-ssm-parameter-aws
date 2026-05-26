output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "parameter_arn" {
  description = "ARN of the SSM parameter"
  value       = try(aws_ssm_parameter.this[0].arn, null)
}

output "parameter_name" {
  description = "Name of the SSM parameter"
  value       = try(aws_ssm_parameter.this[0].name, null)
}

output "parameter_version" {
  description = "Version of the SSM parameter"
  value       = try(aws_ssm_parameter.this[0].version, null)
}
