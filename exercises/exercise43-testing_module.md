# Testing Our Module with EC2 Instances

## Introduction

In this exercise, we will be testing our module with Amazon EC2 instances. We will ensure that our networking module is functioning correctly, and then we will create a new EC2 instance inside one of our created subnets. This will help us understand how to integrate our module with other AWS services and verify its functionality.

## Step-by-Step Guide

1. Start by ensuring that the networking module is correctly working by running `terraform apply` and ensuring that all resources are created.
2. Create a new EC2 instance using the Ubuntu AMI, and deploy this EC2 instance inside the `subnet_1` subnet that we have created with the module.

    ```
    locals {
      project_name = "13-local-modules"
    }

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

    resource "aws_instance" "this" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"
      subnet_id     = module.vpc.private_subnets["subnet_1"].subnet_id

      tags = {
        Name    = local.project_name
        Project = local.project_name
      }
    }
    ```

3. Make sure that everything is working by running `terraform apply` and inspecting the created infrastructure in the AWS console.

4. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've successfully tested a module with Amazon EC2 instances and integrated it with other AWS services. This is a significant step in understanding how to work with Terraform and AWS. Keep up the good work!
