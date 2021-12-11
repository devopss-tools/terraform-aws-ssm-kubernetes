###### Configure provider ######

provider "aws" {
  region  = var.AWS_REGION
}

module "ssm" {
  source               = "../../modules/ssm"
}