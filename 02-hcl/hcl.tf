terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

# Actively managed by us, by our Terraform project
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Managed somewhere else, we just want to use in our project
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

variable "bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "my_default_bucket_name"
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

locals {
  local_example = "This is a local variable"
}

module "my_module" {
  source = "./module-example"
}
