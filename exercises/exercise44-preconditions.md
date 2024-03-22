# Precondition Blocks

## Introduction

In this exercise, you'll be working on creating Precondition Blocks in Terraform. This exercise aims to provide you with an understanding of how to implement rules that must be met before Terraform applies changes to your infrastructure. You'll configure a new Terraform project and create an EC2 instance with an Ubuntu AMI. Additionally, you'll add a precondition block to ensure the chosen instance type matches a list of allowed instance types.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a new folder for this section.
2. Deploy an EC2 instance with an Ubuntu AMI.
3. Create a variable `instance_type` of type string and a default value of `t2.micro`.
4. Create a new `allowed_instance_types` local, containing a list of allowed instance types for our EC2 instance.
5. Define a precondition block in the created EC2 instance to ensure that the `instance_type` variable's value is in the `allowed_instance_types` local.

## Step-by-Step Guide

1. Create a new folder for a new Terraform project, and configure the required Terraform version and the AWS provider with the same versions as we have been using throughout the course.
2. Create a new file named `compute.tf` file and create an EC2 instance with an Ubuntu AMI.

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

    resource "aws_instance" "this" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = var.instance_type

      root_block_device {
        delete_on_termination = true
        volume_size           = 10
        volume_type           = "gp3"
      }
    }
    ```

3. Create a new `variables.tf` file and declare a new variable `instance_type` of type string and with a default value of `t2.micro`.

    ```
    variable "instance_type" {
      type    = string
      default = "t2.micro"
    }
    ```

4. Create a new `allowed_instance_types` local in the `compute.tf` file, and define a list containing only the instance types that should be allowed for our EC2 instance.

    ```
    locals {
      allowed_instance_types = ["t2.micro", "t3.micro"]
    }
    ```

5. Add a precondition block to check that the value received for the `instance_type` variable is contained in the `allowed_instance_types` local. Test your code by running `terraform plan` and confirming that no errors are present. Try to change the default value of the variable to an invalid value, and run `terraform plan` again. Which type of error do we get?

    ```
    resource "aws_instance" "this" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = var.instance_type
      subnet_id     = aws_subnet.this[0].id

      root_block_device {
        delete_on_termination = true
        volume_size           = 10
        volume_type           = "gp3"
      }

      lifecycle {
        precondition {
          condition     = contains(local.allowed_instance_types, var.instance_type)
          error_message = "Invalid instance type"
        }
      }
    }
    ```

## Congratulations on Completing the Exercise!

Congratulations on successfully completing this exercise on creating Precondition Blocks in Terraform! You've taken an important step in understanding how to implement rules that must be met before Terraform applies changes to your infrastructure. Keep up the good work!
