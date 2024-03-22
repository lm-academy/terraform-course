# Our First Terraform Project

## Introduction

In this exercise, we will be creating our first project using Terraform, a popular Infrastructure as Code tool. We will be covering the basics of setting up a Terraform project, configuring the AWS provider, creating a random ID for resource naming, creating an AWS S3 bucket, and outputting the bucket name. This will give you a hands-on introduction to using Terraform to manage AWS resources. Let's get started!

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Set the Terraform version and specify the required providers (`random` and `AWS`).
2. Configure the AWS provider to use the region you are using for the course.
3. Create a Random ID for the AWS S3 bucket name.
4. Create an AWS S3 bucket.
5. Create an output block for the bucket name.

### Useful Resources

-   Terraform Random provider: [https://registry.terraform.io/providers/hashicorp/random/latest/docs](https://registry.terraform.io/providers/hashicorp/random/latest/docs)

## Step-by-Step Guide

1. In the `terraform` block, specify the required Terraform version (`~> 1.7`). Additionally, define the required providers and their versions. In this case, we need the `aws` provider (`~> 5.0`) and the `random` provider (`~> 3.0`).

    ```
    terraform {
      required_version = "~> 1.7"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
        random = {
          source  = "hashicorp/random"
          version = "~> 3.0"
        }
      }
    }
    ```

2. Use the `provider` block to configure the AWS region to `"eu-west-1"`.

    ```
    provider "aws" {
      region = "eu-west-1"
    }
    ```

3. Create a `random_id` resource named `"bucket_suffix"` with a `byte_length` of `6`. This ID will be used to create a unique name for the S3 bucket.

    ```
    resource "random_id" "bucket_suffix" {
      byte_length = 6
    }
    ```

4. Create an `aws_s3_bucket` resource named `"example_bucket"`. Use interpolation to create a unique bucket name by appending the random ID to `"example-bucket-"`.

    ```
    resource "aws_s3_bucket" "example_bucket" {
      bucket = "example-bucket-${random_id.bucket_suffix.hex}"
    }
    ```

5. Finally, use an `output` block to output the name of the created bucket.

    ```
    output "bucket_name" {
      value = aws_s3_bucket.example_bucket.bucket
    }
    ```

6. After you've written the Terraform configuration, run the following Terraform CLI commands in your terminal:
    - `terraform init`: This command initializes your Terraform workspace by downloading the necessary provider plugins.
    - `terraform plan`: This command shows you what changes Terraform will make to your infrastructure without actually making them.
    - `terraform apply`: This command applies the changes, creating the infrastructure.
    - `terraform destroy`: When you're done with the infrastructure, use this command to remove all resources created by your Terraform configuration.

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've taken another step forward in your Terraform journey. Keep practicing and enhancing your skills. Remember, consistent practice is key in mastering any new tool or technology. Congratulations!
