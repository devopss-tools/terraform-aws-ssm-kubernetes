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

variable "service_name" {}

variable "aws_kms_key_env" {}

variable "value_update" {}

variable "PROJECT_SERVICES_LIST_LOCAL_UPDATE" {}