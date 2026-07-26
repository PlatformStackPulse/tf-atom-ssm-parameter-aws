# -----------------------------------------------------------------------------
# Module-Specific Variables
#
# Note: Standard labeling variables (enabled, namespace, tenant, environment,
# stage, name, delimiter, attributes, tags, label_order, etc.) are provided
# by context.tf via the tf-label module.
# -----------------------------------------------------------------------------

variable "parameter_name" {
  description = "Name (path) of the SSM parameter. Defaults to the tf-label id (module.this.id) when null."
  type        = string
  default     = null

  validation {
    condition     = var.parameter_name == null || can(regex("^/?[a-zA-Z0-9_.\\-/]+$", var.parameter_name))
    error_message = "parameter_name must contain only alphanumerics and the characters _ . - / (an optional leading slash is allowed)."
  }
}

variable "description" {
  description = "Description of the SSM parameter."
  type        = string
  default     = null
}

variable "type" {
  description = "Type of the parameter. One of String, StringList, or SecureString."
  type        = string
  default     = "String"

  validation {
    condition     = contains(["String", "StringList", "SecureString"], var.type)
    error_message = "type must be one of: String, StringList, SecureString."
  }
}

variable "tier" {
  description = "Parameter tier. One of Standard, Advanced, or Intelligent-Tiering."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Advanced", "Intelligent-Tiering"], var.tier)
    error_message = "tier must be one of: Standard, Advanced, Intelligent-Tiering."
  }
}

variable "value" {
  description = "Value of the SSM parameter. Required when the module is enabled."
  type        = string
  default     = null
  sensitive   = true
}

variable "key_id" {
  description = "KMS key id/alias/ARN used to encrypt a SecureString parameter. Ignored for non-SecureString types."
  type        = string
  default     = null
}

variable "data_type" {
  description = "Data type of the parameter (e.g. text, aws:ec2:image, aws:ssm:integration)."
  type        = string
  default     = null
}

variable "allowed_pattern" {
  description = "Regular expression used to validate the parameter value."
  type        = string
  default     = null
}
