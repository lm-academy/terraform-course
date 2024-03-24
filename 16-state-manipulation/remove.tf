/*
1. Remove via CLI
2. Remove via the removed block
*/

removed {
  from = aws_s3_bucket.my_new_bucket

  lifecycle {
    destroy = false
  }
}
