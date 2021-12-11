###### Configure provider ######

provider "aws" {
  region  = var.AWS_REGION
}

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "tfstate-backend" {
  source                             = "cloudposse/tfstate-backend/aws"
  version                            = "0.38.1"
  name                               = "terraform"
  namespace                          = var.PROJECT_NAME
  stage                              = var.ENVIRONMENT
  attributes                         = ["state"]
  terraform_backend_config_file_path = "../environments/${var.ENVIRONMENT}"
  terraform_backend_config_file_name = "backend-tfstate.tf"
  force_destroy                      = true
}
