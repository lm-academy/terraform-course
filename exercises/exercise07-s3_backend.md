# Using a Remote S3 Backend

## Introduction

In this exercise, we will guide you through the steps for setting up an S3 backend for Terraform. This allows you to store your Terraform state in an S3 bucket, providing a secure, remote storage solution. Understanding how to set up and use an S3 backend is crucial for managing and collaborating on Terraform projects. Let's get started.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. A manually created S3 bucket used to store the state file, uniquely named and in the region of your choice.
2. S3 backend configured in the Terraform configuration file by referencing the created S3 bucket and providing a relevant key to store the state file.
3. Terraform successfully initialized with the S3 backend.
4. Terraform configuration successfully applied and state stored in the S3 bucket.

### Useful resources

* Terraform backend documentation: [https://developer.hashicorp.com/terraform/language/backend](https://developer.hashicorp.com/terraform/language/backend)

## Step-by-Step Guide

1. First, make sure you have Terraform version 1.7 or later installed. You can check this by running `terraform version` in your terminal.
2. Copy the files from the folder `03-first-tf-project` to a new folder named `04-backends`.
3. You will also need to have the AWS and Random providers installed. These can be installed by running the command `terraform init` inside the `04-backends` folder.
4. Next, you will need to set up your S3 bucket. Choose a unique name for it, and make sure the bucket is created in the region of your choice. You can set this up through the AWS console or using the AWS CLI.
5. Now, you can configure the S3 backend in your Terraform configuration. This is done in the `backend "s3"` block in your configuration file. Replace the `<your-bucket-name>` text with the name of the bucket you have manually created, and the `<your-aws-region>` with the respective region you are using for the course.
    ```
    backend "s3" {
      bucket = "<your-bucket-name>"
      key    = "04-backends/state.tfstate"
      region = "<your-aws-region>"
    }
    ```
6. Configure the AWS provider by using the `provider "aws"` block, and make sure it uses the correct region for your projects.
7. Finally, run `terraform init` again. This will initialize your backend. You should see a message that Terraform has been successfully initialized and that the backend "s3" has been configured.
8. Now, you can run `terraform apply` to apply your configuration. Terraform will store the state in the S3 bucket you configured.
9. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've taken an important step in understanding how to set up and use an S3 backend for Terraform. Keep up the good work!
