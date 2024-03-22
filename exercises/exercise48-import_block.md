# Importing Existing Infrastructure Into Terraform

## Introduction

In this exercise, we will walk through the steps to import an AWS S3 bucket from the “Remote Backends” section into Terraform using the CLI command. We will also apply tags to the imported S3 bucket using Terraform and import the `aws_s3_bucket_public_access_block` resource into Terraform using the `import` block. This exercise will equip you with the knowledge and skills to manage and manipulate pre-existing infrastructure with Infrastructure as Code (IaC) using Terraform.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Successfully import our AWS S3 bucket from the “Remote Backends” section into Terraform using the CLI command.
2. Apply tags to the imported S3 bucket using Terraform.
3. Import the `aws_s3_bucket_public_access_block` resource into Terraform using the `import` block.

## Step-by-Step Guide

1. Create a new file named `import-state.tf`.
2. Let’s work with an already existing piece of infrastructure, which we created when we worked with remote backends. Now we would like to import this bucket into Terraform. If you deleted the bucket, then simply create a new S3 bucket in the AWS console.
3. Check the `aws_s3_bucket` Terraform documentation page for ways to import this resource into an existing Terraform project.
4. Let’s start with using the CLI command. Create a new S3 bucket resource in the `import-state.tf` file.

    ```
    resource "aws_s3_bucket" "remote_state" {
      bucket = "terraform-course-lauromueller-remote-backend"
    }
    ```

5. Use the `terraform import` command and provide the necessary information as specified in the S3 bucket documentation page. Confirm that the import was successful by running `terraform plan` and confirming that there are no changes to the infrastructure.
6. Add some tags to the S3 bucket, run `terraform apply`, and confirm the changes. Congratulations! You have just imported your first resource into Terraform and can now manage it with IaC.

    ```
    resource "aws_s3_bucket" "remote_state" {
      bucket = "terraform-course-lauromueller-remote-backend"

      tags = {
        ManagedBy = "Terraform"
        Lifecycle = "Critical"
      }
    }
    ```

7. Let’s now try working with the `import` block. For that, let’s import a resource called `aws_s3_bucket_public_access_block`. Check the provider documentation for this resource, and check how this can be imported with the `import` block.
8. Create a new `aws_s3_bucket_public_access_block` resource in Terraform, and create an `import` block with the correct configuration.

    ```
    import {
      to = aws_s3_bucket_public_access_block.remote_state
      id = aws_s3_bucket.remote_state.bucket
    }

    resource "aws_s3_bucket_public_access_block" "remote_state" {
      bucket = aws_s3_bucket.remote_state.bucket

      block_public_acls       = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    }
    ```

9. Run `terraform apply` and confirm that everything is correctly imported.

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've successfully learned how to import existing infrastructure into Terraform. This is an essential skill in managing and manipulating pre-existing infrastructure with Infrastructure as Code (IaC) using Terraform. Keep up the good work!
