variable "PROJECT_NAME" {
  description = "PROJECT NAME"
  default     = "Fabacus"
}

variable "AWS_REGION" {
  description = "Deploy region"
}

variable "ENVIRONMENT" {
  description = "Environment name"
}

variable "mfa_delete" {
  type        = bool
  description = "true value if want to Activate MFA delete for S3 tfstate to prevent accidental deletion."
  default     = false
}