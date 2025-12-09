output "s3_bucket_name" {
  description = "The name of the S3 bucket created"
  value       = aws_s3_bucket.weather_bucket.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.weather_bucket.arn
}
