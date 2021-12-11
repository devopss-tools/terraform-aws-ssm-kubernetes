terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "eu-west-1"
    bucket         = "fabacus-development-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "fabacus-development-terraform-state-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
