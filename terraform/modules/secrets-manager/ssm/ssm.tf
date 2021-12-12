module "ssm-parameter-store" {
  source                              = "../ssm-parameter-store"
  count                               = contains(var.PROJECT_SERVICES_LIST_LOCAL_UPDATE, var.service_name) ? 1 : 0
  overwrite                           = "true"
  service_name                        = var.service_name
  aws_kms_key_env                     = var.aws_kms_key_env
  AWS_REGION                          = var.AWS_REGION
  ENVIRONMENT                         = var.ENVIRONMENT
  PROJECT_NAME                        = var.PROJECT_NAME
  PROJECT_SERVICES_LIST_LOCAL_UPDATE  = var.PROJECT_SERVICES_LIST_LOCAL_UPDATE
}

module "ssm-parameter-store-ignore" {
  source                              = "../ssm-parameter-store-ignore"
  count                               = contains(var.PROJECT_SERVICES_LIST_LOCAL_UPDATE, var.service_name) ? 0 : 1
  overwrite                           = "true"
  service_name                        = var.service_name
  aws_kms_key_env                     = var.aws_kms_key_env
  AWS_REGION                          = var.AWS_REGION
  ENVIRONMENT                         = var.ENVIRONMENT
  PROJECT_NAME                        = var.PROJECT_NAME
  PROJECT_SERVICES_LIST_LOCAL_UPDATE  = var.PROJECT_SERVICES_LIST_LOCAL_UPDATE
  depends_on = [
    module.ssm-parameter-store
  ]
}
