resource "aws_s3_bucket" "tf_cloud" {
  bucket = "terraform-cloud-${random_id.this.hex}"

  tags = {
    CreatedBy = "Terraform Cloud"
  }
}