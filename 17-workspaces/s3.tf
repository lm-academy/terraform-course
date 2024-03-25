resource "random_id" "bucket_suffix" {
  byte_length = 4
}

/*
dev     -> 1 bucket
int     -> 1 bucket
staging -> 2 buckets
prod    -> 3 buckets
*/
resource "aws_s3_bucket" "this" {
  count  = var.bucket_count
  bucket = "workspaces-demo-${terraform.workspace}-${count.index}-${random_id.bucket_suffix.hex}"
}