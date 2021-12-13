###### Configure provider ######

provider "aws" {
  region  = var.AWS_REGION
}

module "ssm-init" {
  source                              = "./ssm-parameter-store"
  for_each                            = toset(var.PROJECT_SERVICES_LIST)
  service_name                        = each.key
  aws_kms_key_env                     = aws_kms_key.aws_kms_key_env.id
  AWS_REGION                          = var.AWS_REGION
  ENVIRONMENT                         = var.ENVIRONMENT
  PROJECT_NAME                        = var.PROJECT_NAME
  PROJECT_SERVICES_LIST_LOCAL_UPDATE  = var.PROJECT_SERVICES_LIST_LOCAL_UPDATE
}

module "ssm-init-local" {
  source                              = "./ssm-parameter-store-ignore-local"
  for_each                            = toset(var.PROJECT_SERVICES_LIST_LOCAL_UPDATE)
  service_name                        = each.key
  aws_kms_key_env                     = aws_kms_key.aws_kms_key_env.id
  AWS_REGION                          = var.AWS_REGION
  ENVIRONMENT                         = var.ENVIRONMENT
  PROJECT_NAME                        = var.PROJECT_NAME
  PROJECT_SERVICES_LIST               = var.PROJECT_SERVICES_LIST
  PROJECT_SERVICES_LIST_LOCAL_UPDATE  = var.PROJECT_SERVICES_LIST_LOCAL_UPDATE
  depends_on                          = [ module.ssm-init ]
}


