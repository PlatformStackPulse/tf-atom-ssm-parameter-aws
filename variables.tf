variable "parameter_name" {
  description = "Name suffix for the SSM parameter (prepended with module ID path)"
  type        = string
  validation {
    condition     = length(var.parameter_name) > 0
    error_message = "parameter_name must not be empty."
  }
}

variable "description" {
  description = "Description of the SSM parameter"
  type        = string
  default     = null
}

variable "type" {
  description = "Type of the SSM parameter (String, StringList, SecureString)"
  type        = string
  default     = "SecureString"
  validation {
    condition     = contains(["String", "StringList", "SecureString"], var.type)
    error_message = "type must be String, StringList, or SecureString."
  }
}

variable "value" {
  description = "Value of the SSM parameter"
  type        = string
  sensitive   = true
}

variable "tier" {
  description = "Tier of the SSM parameter (Standard, Advanced, Intelligent-Tiering)"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Advanced", "Intelligent-Tiering"], var.tier)
    error_message = "tier must be Standard, Advanced, or Intelligent-Tiering."
  }
}
