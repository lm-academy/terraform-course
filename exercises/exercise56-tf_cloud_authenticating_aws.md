# Authenticating into AWS with Environment Variables

## Introduction

In this exercise, we will explore how to authenticate into AWS using environment variables. We will create a new access key for our AWS user, set up these keys as environment variables in Terraform Cloud, and then deploy a new S3 bucket to confirm that our setup is working correctly. Let's dive in!

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a new access key for the user we have been using in AWS.
2. Add the new access key information as environment variables in the created workspace in Terraform Cloud.
3. Create a new S3 bucket in the Terraform project, and make sure it is successfully deployed in AWS.

## Step-by-Step Guide

1. Login into AWS with the user you have been using throughout the course.
2. Navigate to the IAM console within the AWS platform, and select the relevant user.
3. Under the “Security Credentials” tab, click on “Create access key”. This will create a second access key for you to use in Terraform Cloud.
4. Select Command Line Interface (CLI), accept the recommendations, and click on “Next”.
5. Add relevant descriptions, and click on Save.
6. In Terraform Cloud, select the workspace `terraform-cli`, and click on “Variables” on the left-side menu.
7. Scroll down until you can see a place to add variables.
8. Add a new environment variable `AWS_ACCESS_KEY_ID` to store the Key ID from the newly created access key. Mark the environment variable as sensitive.
9. Add a new environment variable `AWS_SECRET_ACCESS_KEY` to store the Secret Access Key from the newly created access key. Mark the environment variable as sensitive.
10. Back in the Terraform project, add the `hashicorp/aws` provider, and configure it based on the region you are working with.
11. Create a new file `s3.tf` to create a new S3 bucket. Use the random_id resource we have created to make the name of the bucket unique.

    ```
    resource "aws_s3_bucket" "tf_cloud" {
      bucket = "terraform-cloud-${random_id.this.hex}"

      tags = {
        CreatedBy = "Terraform Cloud"
      }
    }
    ```

12. Run `terraform apply` and go back to Terraform Cloud. Confirm that everything is working by confirming the plan and inspecting the AWS S3 console.

## Congratulations on Completing the Exercise!

Well done on successfully completing this exercise! You've taken important steps in learning how to authenticate into AWS using environment variables and deploying resources securely through Terraform Cloud. Keep up the excellent work!
