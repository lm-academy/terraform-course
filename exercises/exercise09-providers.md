# Working with Providers

## Introduction

In this exercise, we will explore the concept of Providers in Terraform, specifically focusing on AWS providers. We will learn how to configure multiple instances of AWS providers, each targeting a different region. By the end of this exercise, you will be able to deploy resources in different AWS regions using separate provider instances. Let's get started!

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Configure the default AWS provider to use the region of your choice (`eu-west-1` in this case).
2. Configure another instance of the AWS provider with the region set to `us-east-1` and an alias of `us-east`.
3. Create an S3 bucket resource in the `eu-west-1` region.
4. Create an S3 bucket resource in the `us-east-1` region.

## Step-by-Step Guide

1. Within your Terraform project folder, create a file `provider.tf` and declare the required Terraform version and the AWS provider source and version in a `required_providers` block within a `terraform` block:

    ```
    terraform {
      required_version = "~> 1.7"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }
    ```

2. Configure the default `aws` provider to use the region of your choice (in my case, this is `eu-west-1`):

    ```
    provider "aws" {
      region = "eu-west-1"
    }
    ```

3. Configure another instance of the `aws` provider by adding another `provider` block and setting the region to `us-east-1`. Also assign it an alias so that it can be later used with resources:

    ```
    provider "aws" {
      region = "us-east-1"
      alias  = "us-east"
    }
    ```

4. Create an S3 bucket resource in the `eu-west-1` region:

    ```
    resource "aws_s3_bucket" "eu_west_1" {
      bucket = "some-random-bucket-name-aosdhfoadhfu"
    }
    ```

5. Create another S3 bucket resource in the `us-east-1` region. This time, specify the provider by using the alias you created earlier and passing it to the `provider` argument of the resource:

    ```
    resource "aws_s3_bucket" "us_east_1" {
      bucket   = "some-random-bucket-name-18736481364"
      provider = aws.us-east
    }
    ```

6. Initialize Terraform in your project directory using the command `terraform init`.
7. Validate your configuration using the command `terraform validate`.
8. If the configuration is valid, apply it using the command `terraform apply`.
9. Use the AWS console or CLI to check that the resources were correctly deployed in both regions.
10. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've successfully explored the concept of Providers in Terraform and specifically focused on AWS providers. You've learned how to configure multiple instances of AWS providers, each targeting a different region, and you've deployed resources in different AWS regions using separate provider instances. Keep up the good work!
