# Working with Sensitive Values

## Introduction

In this exercise, we will delve into the process of handling sensitive values in Terraform. We'll learn how to set certain values as sensitive and how to retrieve them. Moreover, we'll understand the implications of setting a sensitive value and how it impacts the logs output by Terraform. This hands-on exercise will provide you a practical understanding of working with sensitive data, which is a crucial aspect of managing infrastructure.

## Step-by-Step Guide

1. Let’s start by setting the `s3_bucket_name` as sensitive by adding a `sensitive = true` to the output block.

    ```
    output "s3_bucket_name" {
      value       = aws_s3_bucket.project_bucket.bucket
      sensitive   = true
      description = "The name of the S3 bucket"
    }
    ```

2. Retrieve the value of the output with `terraform output s3_bucket_name`. As you can see, we have no problems retrieving the value of outputs set as sensitive.
3. Create a variable called `my_sensitive_value` containing a sensitive value, and reflect this directly in an output named `sensitive_var`:

    ```
    variable "my_sensitive_value" {
      type      = string
      sensitive = true
    }

    output "sensitive_var" {
      sensitive = true   # We must set this to true since the variable is sensitive!
      value     = var.my_sensitive_value
    }
    ```

4. Use the `my_sensitive_value` to create a new tag in the `local.common_tags` object we have created in previous lectures. What happens in the logs output by Terraform?

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've taken a significant step in understanding how to handle sensitive values in Terraform. Keep up the good work!
