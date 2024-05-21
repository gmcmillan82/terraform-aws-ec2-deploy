resource "aws_s3_bucket" "backup_bucket" {
  # Change bucket name to something unique
  bucket = var.bucket_name
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}
