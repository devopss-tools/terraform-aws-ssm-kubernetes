provider "aws" {
  region  = var.AWS_REGION
}

provider "kubernetes" {
  config_path    = "../../../kubeconfig.${var.ENVIRONMENT}"
}