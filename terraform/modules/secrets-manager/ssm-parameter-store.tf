module "ssm-init" {
  for_each                            = toset(var.PROJECT_SERVICES_LIST)
  service_name                        = "${each.key}"
  source                              = "./ssm"
  value_update                        = contains(var.PROJECT_SERVICES_LIST_LOCAL_UPDATE, each.key) ? "./ssm-parameter-store-ignore" : "./ssm-parameter-store"
  aws_kms_key_env                     = aws_kms_key.aws_kms_key_env.id
  AWS_REGION                          = var.AWS_REGION
  ENVIRONMENT                         = var.ENVIRONMENT
  PROJECT_NAME                        = var.PROJECT_NAME
  PROJECT_SERVICES_LIST_LOCAL_UPDATE  = var.PROJECT_SERVICES_LIST_LOCAL_UPDATE
}