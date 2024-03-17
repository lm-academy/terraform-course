terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east"
}

resource "aws_s3_bucket" "eu_west_1" {
  bucket = "some-random-bucket-name-aosdhfoadhfu"
}

resource "aws_s3_bucket" "us_east_1" {
  bucket   = "some-random-bucket-name-18736481364"
  provider = aws.us-east
}