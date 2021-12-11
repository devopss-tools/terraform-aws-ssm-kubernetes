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

variable "PROJECT_SERVICES_NAME" {
  type = list
  description = "Project Services names"
}