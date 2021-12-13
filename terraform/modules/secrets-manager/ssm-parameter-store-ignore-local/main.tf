resource "aws_ssm_parameter" "secret" {
  count           = contains(var.PROJECT_SERVICES_LIST, var.service_name) ? 0 : 1
  name            = "/${var.PROJECT_NAME}/${var.ENVIRONMENT}/${var.service_name}-vars-secrets"
  description     = "The parameter description"
  type            = "SecureString"
  value           = file("../../../.env.${var.ENVIRONMENT}.${var.service_name}")
  key_id          = var.aws_kms_key_env
  tier            = "Standard"  # Free up to 10k, size 4KB, parameter policies is not available but envs separated in diferent AWS accounts
  overwrite       = true
  tags = {
    Name          = "/${var.PROJECT_NAME}/${var.ENVIRONMENT}/${var.service_name}-vars-secrets"
    ManagedBy     = "Terraform"
    environment   = var.ENVIRONMENT
  }
}