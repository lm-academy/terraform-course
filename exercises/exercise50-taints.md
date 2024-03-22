# Replacing Resources with Taints

## Introduction

In this exercise, we will explore the concept of "tainting" in Terraform, which is a way to mark a resource for recreation in the next plan. We'll learn how to use the `terraform taint` and `terraform untaint` commands to control the lifecycle of our resources. This will involve creating and managing an S3 bucket and a VPC, and observing how tainting these resources affects their associated resources. We'll also delve into how to handle potential issues that can arise from the recreation of tainted resources. This exercise will enhance your understanding of resource dependencies and lifecycle management in Terraform.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create an S3 bucket.
2. Taint and untaint the bucket via the CLI.
3. Create a VPC and a subnet within the created VPC with correct CIDR blocks.
4. Taint the VPC and inspect how its recreation triggers the recreation of the subnet.
5. Create an `aws_s3_bucket_public_access_block` resource, and set the options `block_public_acls` and `block_public_policy` to false.
6. Taint the S3 bucket and inspect how its recreation **does not** trigger the recreation of the `aws_s3_bucket_public_access_block` resource. What are the consequences of this behavior? Can we tackle this using lifecycle meta-arguments?

## Step-by-Step Guide

1. Create a new file named `taint.tf` and create an S3 bucket within the file. Run `terraform apply` to create the bucket.

    ```
    resource "aws_s3_bucket" "tainted" {
      bucket = "my-tainted-bucket-19384981jhahds"
    }
    ```

2. Taint the bucket by using the CLI command `terraform taint aws_s3_bucket.tainted`. Run the `terraform apply` command and verify that Terraform has marked the resource for recreation.
3. Untaint the bucket by running `terraform untaint aws_s3_bucket.tainted`. Verify that Terraform will not try to recreate the resource anymore.
4. Let’s now see how Terraform handles dependent resources when a tainted resource is recreated. For that, create a VPC and subnet using the same CIDR blocks we have been using so far. Create the resources with `terraform apply`.

    ```
    resource "aws_vpc" "this" {
      cidr_block = "10.0.0.0/16"
    }

    resource "aws_subnet" "this" {
      vpc_id     = aws_vpc.this.id
      cidr_block = "10.0.0.0/24"
    }
    ```

5. Taint the `aws_vpc` we have created, and run the terraform apply command. What does the output look like?
6. Terraform will not always recreate downstream resources by default. To visualize that, add an `aws_s3_bucket_public_access_block` resource to the S3 bucket. Set both the `block_public_acls` and `block_public_policy` to false, so that we can visualize the issue more easily.

    ```
    resource "aws_s3_bucket_public_access_block" "from_tainted" {
      bucket = aws_s3_bucket.tainted.bucket

      block_public_acls       = false
      block_public_policy     = false
      ignore_public_acls      = true
      restrict_public_buckets = true
    }
    ```

7. Confirm the creation via `terraform apply`, and verify that the public access block is correctly configured in the AWS console.
8. Taint the S3 bucket, and then run `terraform apply`. Confirm the changes, and then check how the public access block is configured in the AWS console. Does it match the configuration we have in the Terraform configuration?
9. Make sure to delete the infrastructure before finishing this exercise!

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've taken another important step in mastering Terraform! The knowledge you've acquired about tainting and untainting resources will be crucial in managing your Terraform infrastructure. Keep up the good work!
