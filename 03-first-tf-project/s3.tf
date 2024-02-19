resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "example-bucket-${random_id.bucket_suffix.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.example_bucket.bucket
}