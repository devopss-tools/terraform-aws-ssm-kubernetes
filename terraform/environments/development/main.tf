###### Configure provider ######

provider "aws" {
  region  = var.AWS_REGION
}

module "secrets-manager" {
  source                              = "../../modules/secrets-manager"
  AWS_REGION                          = var.AWS_REGION
  ENVIRONMENT                         = var.ENVIRONMENT
  PROJECT_NAME                        = var.PROJECT_NAME
  PROJECT_SERVICES_LIST               = var.PROJECT_SERVICES_LIST
  PROJECT_SERVICES_LIST_LOCAL_UPDATE  = var.PROJECT_SERVICES_LIST_LOCAL_UPDATE
}