# Refactoring Configuration with the CLI and Moved Blocks

## Introduction

In this exercise, we will be exploring the process of refactoring configuration with the help of the Command Line Interface (CLI) and moved blocks. We will be working with the manipulation of Terraform state and EC2 instances. The main goal of this exercise is to familiarize you with operations such as renaming instances, migrating blocks, and using the `moved` block. By the end of this exercise, you should have a good understanding of how to make efficient changes to your infrastructure without unnecessary resource recreation.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should execute:

1. Create a new folder for the following exercises.
2. Create a new EC2 instance labeled `default`.
3. Use the `terraform state mv` command to relabel the EC2 instance to `new`.
4. Migrate the `aws_instance` block to deploy two instances using the `count = 2` meta-argument, and migrate the existing instance to the first item on the new instance list.
5. Migrate to using `for_each` instead of count, and use a local variable to define two strings that are to be used as the identifiers for the instances.
6. Use the `moved` block instead of the CLI to move the two resources from our list to the newly defined EC2 resources.

## Step-by-Step Guide

1. Create a new folder to organize the files related to the state manipulation section.
2. Create a new `provider.tf` file and configure Terraform as we have been doing so far. Add the AWS provider, following the same version constraints as in previous exercises. Also configure the AWS provider with the region of your choice.
3. To understand the motivation for refactoring configuration, create a new EC2 instance in the project. Run `terraform apply` to create the new instance.

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

    resource "aws_instance" "default" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"
    }
    ```

4. Change the `aws_instance` label from default to `new`. Run `terraform apply` and inspect what happens. Is it really necessary to recreate resources? Cancel the operation and proceed to the next step.
5. Use the `terraform state mv -dry-run [OLD-REFERENCE] [NEW-REFERENCE]` to visualize the operation that we can perform to rename our resource in the Terraform state. Run the command again without the `-dry-run` option, and then run `terraform apply`. There should be no changes to the infrastructure.
6. Let’s now deploy two instances. Add a `count = 2` meta-argument to the `aws_instance` block. Run `terraform apply`. How did Terraform handle this operation?
7. Although Terraform can handle simple migrations from single to multiple resources with the count meta-argument, if we relabel the resource we will still run into problems. Try changing the label to `new_list` and then run `terraform apply`. Terraform should want to perform more operations than necessary.
8. Use the `terraform state mv aws_instance.new 'aws_instance.new_list[0]'` command to move our existing instance to the first element of the new list. Running `terraform apply` should now lead only to the creation of a single instance.
9. Let’s now migrate to using `for_each` instead of count. Store two strings in a local named `ec2_names`, and migrate the EC2 instance code to create instances based on those names.

    ```
    locals {
      ec2_names = ["instance1", "instance2"]
    }

    resource "aws_instance" "new_final" {
      for_each      = toset(local.ec2_names)
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"
    }
    ```

10. Which CLI commands should we run? Instead of using the CLI, let’s now adopt a different approach and use the `moved` block. Move the two resources from our list to the newly defined resources.

    ```
    moved {
      from = aws_instance.new_list[0]
      to   = aws_instance.new_list["instance1"]
    }

    moved {
      from = aws_instance.new_list[1]
      to   = aws_instance.new_list["instance2"]
    }
    ```

11. Run `terraform plan` and inspect what Terraform outputs. Confirm the operation by running `terraform apply` and typing “yes”.
12. Make sure to destroy the infrastructure before finishing the exercise!

## Congratulations on Completing the Exercise!

Congratulations on completing this exercise on refactoring configuration with the CLI and moved blocks! You've done an excellent job and should now have a better understanding of Terraform state manipulation. Keep up the great work!
