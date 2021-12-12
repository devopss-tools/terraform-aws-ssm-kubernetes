variable "service_name" {}
variable "aws_kms_key_env" {}
variable "overwrite" {}
variable "PROJECT_SERVICES_LIST_LOCAL_UPDATE" {}

resource "aws_ssm_parameter" "secret" {
  name            = "/${var.PROJECT_NAME}/${var.ENVIRONMENT}/${var.service_name}-vars-secrets"
  description     = "The parameter description"
  type            = "SecureString"
  value           = fileexists("../../../.env.${var.ENVIRONMENT}.${var.service_name}") ? file("../../../.env.${var.ENVIRONMENT}.${var.service_name}") : "default_terraform=null"
  key_id          = var.aws_kms_key_env
  tier            = "Standard"  # Free up to 10k, size 4KB, parameter policies is not available but envs separated in diferent AWS accounts
  overwrite       = var.overwrite
  lifecycle {
    ignore_changes =  [
      value
    ]
  }
  tags = {
    Name          = "/${var.PROJECT_NAME}/${var.ENVIRONMENT}/${var.service_name}-vars-secrets"
    ManagedBy     = "Terraform"
    environment   = var.ENVIRONMENT
  }
}