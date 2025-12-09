provider "aws" {
  region = var.aws_region
}

# Create S3 bucket
resource "aws_s3_bucket" "weather_bucket" {
  bucket = var.bucket_name

  object_lock_enabled = false

  tags = {
    Project = "Weather Data Collection System"
  }
}

# Disable S3 Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.weather_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Enable ACLs – required for public access
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.weather_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

# Set bucket ACL to public-read
resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_public_access_block.public_access,
    aws_s3_bucket_ownership_controls.ownership
  ]

  bucket = aws_s3_bucket.weather_bucket.id
  acl    = "public-read"
}

# Public read policy (allows viewing JSON from browser)
resource "aws_s3_bucket_policy" "public_read_policy" {
  depends_on = [
    aws_s3_bucket_public_access_block.public_access,
    aws_s3_bucket_acl.bucket_acl
  ]

  bucket = aws_s3_bucket.weather_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}
