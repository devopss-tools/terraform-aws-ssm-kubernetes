###### Configure provider ######
terraform {
  required_providers {
    dotenv = {
      source  = "jrhouston/dotenv"
      version = "~> 1.0"
    }
  }
}

data "aws_ssm_parameter" "ssm" {
  name      = "/${var.PROJECT_NAME}/${var.ENVIRONMENT}/${var.service_name}-vars-secrets"
  with_decryption   = "true"
}

data dotenv dev_config {
  string    = data.aws_ssm_parameter.ssm.value
  depends_on  = [ data.aws_ssm_parameter.ssm ]
}


resource "kubernetes_secret" "k8s-secret" {
  metadata {
    name      = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-${var.service_name}-vars-secrets"
    namespace = "${var.ENVIRONMENT}"
  }
  data = { for k, v in data.dotenv.dev_config.env : k => v }
  type = "kubernetes.io/Opaque"
  depends_on  = [ data.dotenv.dev_config ]
}
