# Working with Multiple Workspaces

## Introduction

In this exercise, we will explore how to work with multiple Terraform workspaces. We will learn how to extend the bucket name to include the `terraform.workspace` expression in its value, and apply changes across different workspaces. We will also delve into the appropriate and inappropriate use of the `terraform.workspace` value in our Terraform configuration. By the end of this exercise, you will understand how to efficiently manage and manipulate multiple workspaces in Terraform.

## Step-by-Step Guide

1. Extend the bucket name to include the `terraform.workspace` expression in its value. Apply the changes with terraform apply in both `dev` and `default` workspaces.

    ```
    resource "random_id" "bucket_suffix" {
      byte_length = 4
    }

    resource "aws_s3_bucket" "this" {
      bucket = "workspaces-demo-${terraform.workspace}-${random_id.bucket_suffix.hex}"
    }
    ```

2. **Bad code spoiler alert!** Let’s explore how not to use the value from terraform.workspace in our Terraform configuration. For that, let’s first create two more workspaces: `prod` and `staging`. Now extend the S3 bucket configuration to deploy multiple buckets based on the following rules:

    1. 3 buckets should be deployed in the `prod` workspace.
    2. 2 buckets should be deployed in the `staging` workspace.
    3. 1 bucket should be deployed in the `dev` workspace.

    We also need to add the `count.index` value to the bucket name so that it is unique. Here is how **not** to use `terraform.workspace`!

    ```
    resource "aws_s3_bucket" "this" {
      count  = terraform.workspace == "prod" ? 3 : terraform.workspace == "staging" ? 2 : 1
      bucket = "workspaces-demo-${terraform.workspace}-${count.index}-${random_id.bucket_suffix.hex}"
    }
    ```

3. Try applying this configuration in the three different workspaces we have created. Although this works, the code above is very difficult to read and maintain. There is a much better way of doing that, and we will do that in the next exercise.

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've made some great progress in understanding how to manage and manipulate multiple workspaces in Terraform. This is a significant step towards mastering Terraform. Keep up the good work!
