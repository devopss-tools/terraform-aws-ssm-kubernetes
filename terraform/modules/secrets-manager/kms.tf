resource "aws_kms_key" "aws_kms_key_env" {
  description             = "KMS key using for ${var.PROJECT_NAME} environment ${var.ENVIRONMENT}"
  deletion_window_in_days = 10
  tags = {
    Name          = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-kms-key"
    ManagedBy     = "Terraform"
    environment   = var.ENVIRONMENT
  }
}

resource "aws_kms_alias" "aws_kms_alias_env" {
  name          = "alias/${var.PROJECT_NAME}-${var.ENVIRONMENT}-kms-key-alias"
  target_key_id = aws_kms_key.aws_kms_key_env.key_id
}