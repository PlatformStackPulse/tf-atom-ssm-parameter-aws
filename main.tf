# -----------------------------------------------------------------------------
# tf-atom-ssm-parameter-aws
#
# Single-resource atom: one aws_ssm_parameter, named via tf-label (module.this.id)
# and gated by the standard `enabled` flag from context.tf.
# -----------------------------------------------------------------------------

resource "aws_ssm_parameter" "this" {
  count = local.enabled ? 1 : 0

  name            = coalesce(var.parameter_name, module.this.id)
  description     = var.description
  type            = var.type
  tier            = var.tier
  value           = var.value
  key_id          = var.type == "SecureString" ? var.key_id : null
  data_type       = var.data_type
  allowed_pattern = var.allowed_pattern

  tags = local.tags
}
