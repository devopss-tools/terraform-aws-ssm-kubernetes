resource "aws_ssm_parameter" "secret" {
  name            = "/${var.PROJECT_NAME}/${var.ENVIRONMENT}/${var.service_name}-vars-secrets"
  description     = "The parameter description"
  type            = "SecureString"
  value           = "default_terraform=null"
  key_id          = var.aws_kms_key_env
  tier            = "Standard"
  overwrite       = false
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