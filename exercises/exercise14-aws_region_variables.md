# Receiving the AWS Region via Variables

## Introduction

In this exercise, we will explore how to receive the AWS Region using variables in Terraform. This will allow us to dynamically set the region in which our resources will be created. However, it's important to note that this approach comes with its own set of challenges, and we need to be aware of the potential pitfalls. The exercise will guide you through creating and applying Terraform configuration files, and observing the behavior when changing the region. By the end of the exercise, you'll have a deeper understanding of how Terraform handles regions, instances, and the importance of carefully managing your resources.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a `variables.tf` file with a single variable named `aws_region`.
2. Create a `provider.tf` file with the standard configuration code we have been using so far (Terraform required version and the AWS provider requirements).
3. Use the `aws_region` variable to set the region for configuring the `aws` provider.
4. Create an EC2 instance using the `aws_ami` data source for the Ubuntu AWS AMI.

## Step-by-Step Guide

1. Create a `variables.tf` file and declare a single variable named `aws_region`. If you do not assign a default value to the variable, you'll need to provide the value when you run Terraform commands.
2. Create a `provider.tf` file and add the standard configuration code we have been using for our Terraform projects.

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

3. Use the `aws_region` variable to set the region of the `aws` provider.

    ```
    provider "aws" {
      region = var.aws_region
    }
    ```

4. This pattern is very dangerous! Can you guess why? Let’s create an EC2 instance to check what can go wrong here. Create a data source to retrieve the Ubuntu AWS AMI, and an EC2 instance, as we have done in previous sections.

    ```
    data "aws_ami" "ubuntu" {
      most_recent = true
      owners      = ["099720109477"] # Owner is Canonical

      filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
      }

      filter {
        name   = "virtualization-type"
        values = ["hvm"]
      }
    }

    resource "aws_instance" "compute" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"

      root_block_device {
        delete_on_termination = true
        volume_size           = 10
        volume_type           = "gp3
      }
    }
    ```

5. Now run the `terraform apply` command and pass the region you have been working on so far as a value to the created variable. Everything should work as expected.
6. Run the `terraform plan` command, but now pass a different region. What happens as a result? Does Terraform plan to destroy the previously created EC2 instance? How many instances would exist in each region if you were to apply this plan?
7. As you can see, Terraform **will not destroy** previously created instances in another region! This can lead to many resources being simply “forgotten” by Terraform, which can be very troublesome!
8. As a final step, remove the `aws_region` variable and hard-code the correct region in the `provider "aws"` configuration block.
9. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Well done on successfully completing this exercise! You've taken an important step in understanding how to work with AWS Regions and variables in Terraform. This knowledge is crucial in managing and deploying resources across multiple regions. Keep up the good work!
