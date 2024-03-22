# Referencing Resources with `count` Arguments

## Introduction

In this exercise, we will explore how to reference resources created with `count` arguments in Terraform. We will create a new variable to determine the number of EC2 instances to be created, leverage a data source to read an Ubuntu AWS AMI, and distribute these instances across different subnets. This exercise provides practical experience with the use of variables, data sources, and resource creation in Terraform.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a new variable, `ec2_instance_count`, of type number and with a default value of 1.
2. Create a data source that reads an Ubuntu AWS AMI.
3. Create an `aws_instance` resource that uses the `ec2_instance_count` variable to create multiple EC2 instances.
4. Distribute the EC2 instances equally across all the subnets we have created in the previous exercise.

## Step-by-Step Guide

1. Create a new variable, `ec2_instance_count`, which is of type number and has a default value of 1.

    ```
    variable "ec2_instance_count" {
      type    = number
      default = 1
    }
    ```

2. Create a data source that reads an Ubuntu AWS AMI as we have defined in previous exercises, and an `aws_instance` resource that leverages the `ec2_instance_count` variable to create multiple EC2 instances. Run a `terraform plan` command to inspect if there will be any issues.

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

    resource "aws_instance" "from_count" {
      count         = var.ec2_instance_count
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"

      tags = {
        Name    = "${local.project}-${count.index}"
        Project = local.project
      }
    }
    ```

3. Set the subnet ID to be that of the first subnet created in our `aws_subnet.main` resource. Run a `terraform apply` command, confirm the changes, and make sure that it is deployed in the correct subnet.

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

    resource "aws_instance" "from_count" {
      count         = var.ec2_instance_count
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"
      subnet_id     = aws_subnet.main[0].id

      tags = {
        Name    = "${local.project}-${count.index}"
        Project = local.project
      }
    }
    ```

4. Let’s now create four EC2 instances. Create a `terraform.tfvars` file, and set the `ec2_instance_count` variable to 4. We also want to distribute these EC2 instances equally across the subnets we have created. How can we achieve this with what we have learned so far? (**Hint:** We can dynamically calculate the index that we use to access the subnet.)

    ```
    resource "aws_instance" "from_count" {
      count         = var.ec2_instance_count
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"
      subnet_id     = aws_subnet.main[
        count.index % length(aws_subnet.main)
      ].id

      tags = {
        Name    = "${local.project}-${count.index}"
        Project = local.project
      }
    }
    ```

5. Run `terraform apply` and inspect the changes.
6. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Great job! You've successfully completed this exercise on referencing resources with count arguments in Terraform. You've learned how to use variables, data sources, and resource creation to manage and distribute multiple EC2 instances across different subnets. Keep up the good work!
