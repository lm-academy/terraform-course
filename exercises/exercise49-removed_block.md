# Removing Infrastructure from Terraform

## Introduction

In this exercise, we will explore how to remove infrastructure from Terraform. This process involves creating an S3 bucket, removing it from the Terraform configuration using the Command Line Interface (CLI), and then reimporting it. We will also experiment with the `removed` block and its functionality. This exercise is designed to give you a better understanding of how Terraform handles resource management and the removal of resources.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a new S3 bucket in Terraform.
2. Remove the S3 bucket from the Terraform configuration using the CLI approach.
3. Import the bucket once again and try using the `removed` block for forgetting the resource.

## Step-by-Step Guide

1. Let’s now evaluate how we can make Terraform forget objects and stop tracking their configuration. This is useful when we want to keep the object but remove it from a specific Terraform configuration.
2. Add a new file named `remove.tf` and create a new S3 bucket inside the file.

    ```
    resource "aws_s3_bucket" "my_bucket" {
      bucket = "random-name-<some random string>"
    }
    ```

3. Let’s first try the CLI approach. Run `terraform state rm -dry-run aws_s3_bucket.my_bucket`. This will only show what Terraform plans to forget, without actually forgetting it. Run the command again without the `-dry-run` option. This will remove the resource from the Terraform configuration.
4. Delete (or comment out) the S3 bucket resource block from the file and run `terraform apply` to confirm that nothing will be deleted. The bucket still exists, but now it’s not tracked by our configuration anymore.
5. Add the bucket resource block (or uncomment it) back and import the resource into the configuration.
6. Let’s now try with the `removed` block. Add the following code to the `remove.tf` file. Comment out the S3 bucket code and run `terraform plan`.

    ```
    removed {
      from = aws_s3_bucket.my_new_bucket

      lifecycle {
        destroy = true
      }
    }
    ```

7. Try changing the `destroy` flag to `false` and run `terraform plan` once again. How is this different from the previous scenario where `destroy` was set to `true`?

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've taken an important step in understanding how Terraform handles resource management and the removal of resources. Keep up the good work!
