variable "bucket_name" {
  description = "Name of the S3 bucket to store weather data"
  type        = string
  default     = "my-weather-data-bucket-pr-2025"
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}
