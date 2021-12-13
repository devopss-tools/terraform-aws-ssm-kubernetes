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

variable "PROJECT_SERVICES_LIST" {
  type = list
  description = "Project Services names"
}

variable "PROJECT_SERVICES_LIST_LOCAL_UPDATE" {
  type = list
  description = "Project Services names"
}

variable "service_name" {}

variable "aws_kms_key_env" {}