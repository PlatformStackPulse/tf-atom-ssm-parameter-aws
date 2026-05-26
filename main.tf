resource "aws_ssm_parameter" "this" {
  count = module.this.enabled ? 1 : 0

  name        = "/${module.this.id}/${var.parameter_name}"
  description = coalesce(var.description, "SSM parameter: ${var.parameter_name}")
  type        = var.type
  value       = var.value
  tier        = var.tier

  tags = local.tags
}
