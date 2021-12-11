output "s3_bucket_arn" {
  description = "ARN of the S3 bucket the state is stored"
  value       = module.tfstate-backend.s3_bucket_arn
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = module.tfstate-backend.dynamodb_table_arn
}