# Understanding Workspace Variables

## Introduction

In this exercise, you'll learn how to use workspace variables in Terraform. This is an important skill to have as it allows you to manage and organize your Terraform configurations in a more efficient manner. You will specifically be creating a variable for an EC2 instance type and storing its value in Terraform Cloud. You will use this variable to deploy an EC2 instance and then destroy all resources at the end of the exercise. This hands-on exercise will help you understand the process of using workspace variables in Terraform and provide you with practical experience. Let's get started!

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a variable to specify the instance type for an EC2 instance, and store its value in Terraform Cloud.
2. Deploy the EC2 instance with an Ubuntu AMI.
3. Destroy all resources at the end of the exercise.

## Step-by-Step Guide

1. In the Terraform project code, create a new variable named `ec2_instance_type`, of type string, and with a validation ensuring that its value equals the free tier from your region.
2. Navigate to the `terraform-cli` workspace in Terraform Cloud, and navigate to the Variables section on the left-side menu.
3. Create a new Terraform variable (not Environment variable), name it `ec2_instance_type`, and add the value of the instance type that is included in your free tier.
4. In the Terraform project code, create a new `compute.tf` file and add the necessary code for deploying an EC2 instance with the Ubuntu AMI. Use the variable to define the instance type. Also add relevant tags to the EC2 instance.
5. Run `terraform apply`, and double check that the variable value is being correctly populated (you can do that in the Terraform Cloud portal, or via the CLI).
6. After the apply is successful, run `terraform destroy` in the CLI and inspect what is different in the Terraform Cloud console. Confirm the destroy operation, and wait for it to complete.

## Congratulations on Completing the Exercise!

Well done on completing the exercise on understanding workspace variables in Terraform! You've taken an important step in mastering the use of Terraform configurations. Keep up the great work!
