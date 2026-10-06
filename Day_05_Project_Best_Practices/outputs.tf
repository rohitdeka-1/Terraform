//In Terraform, outputs acts as the return values of your module.

output "bucket_id" {
  value       = aws_s3_bucket.assets.id
  description = "The name/ID of the created S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.assets.arn
  description = "The ARN of the created S3 bucket"
}

