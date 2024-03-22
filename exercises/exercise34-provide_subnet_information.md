# Passing Subnet Information in the Configuration

## Introduction

This exercise is designed to guide you through the process of passing subnet configuration in an infrastructure code. You will learn how to create a map variable for subnet configuration, add a validation rule for CIDR blocks, create a resource block for the AWS subnet, and more. This practical exercise aims to enrich your understanding of Terraform and AWS, specifically in managing EC2 instances and subnets.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a map variable for the subnet configuration, where each entry receives a CIDR block.
2. Add a validation rule to ensure that all provided CIDR blocks are valid.
3. Create a resource block for the AWS subnet, which creates a subnet for each item in the subnet configuration map.
4. Extend the existing EC2 instance configuration variables by adding a new property that receives the subnet in which to deploy the instance.

## Step-by-Step Guide

1. Begin by creating a variable for the subnet configuration. This variable is of type map, and each value in this map is an object with a single attribute `cidr_block` that is a string. This will allow you to pass a map of subnet configurations, where each configuration includes a CIDR block.

    ```
    variable "subnet_config" {
      type = map(object({
        cidr_block = string
      }))
    }
    ```

2. Add a validation rule to ensure that all provided CIDR blocks are valid. This rule uses the `cidrnetmask` function to check if each CIDR block is valid, and the `alltrue` function to ensure that all CIDR blocks are valid. If any CIDR block is not valid, an error message will be displayed.

    ```
    validation {
      condition = alltrue([
        for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
      ])
      error_message = "At least one of the provided CIDR blocks is not valid."
    }
    ```

3. Create a resource block for the AWS subnets. This block creates a subnet for each item in `var.subnet_config`. Each subnet will be associated with the `main` VPC (if not created, create a new `aws_vpc.main` resource with a CIDR block of `10.0.0.0/16`), and its CIDR block will be set to the `cidr_block` from the subnet configuration. The subnet will also be tagged with a `Project` tag set to the project name and a `Name` tag set to a combination of the project name and the key from the subnet configuration.

    ```
    resource "aws_subnet" "main" {
      for_each   = var.subnet_config
      vpc_id     = aws_vpc.main.id
      cidr_block = each.value.cidr_block

      tags = {
        Project = local.project
        Name    = "${local.project}-${each.key}"
      }
    }
    ```

4. Extend the existing `ec2_instance_config_list` and `ec2_instance_config_map` variables by adding a new property `subnet_name` to optionally receive the subnet key to deploy the instance. If no value is provided, set the property value to `default`.

    ```
    variable "ec2_instance_config_list" {
      type = list(object({
        instance_type = string
        ami           = string
        subnet_name   = optional(string, "default")
      }))

      default = []

      # Ensure that only t2.micro is used
      validation {
        ...
      }

      # Ensure that only ubuntu and nginx images are used.
      validation {
        ...
      }
    }

    variable "ec2_instance_config_map" {
      type = map(object({
        instance_type = string
        ami           = string
        subnet_name   = optional(string, "default")
      }))

      # Ensure that only t2.micro is used
      validation {
        ...
      }

      # Ensure that only ubuntu and nginx images are used.
      validation {
        ...
      }
    }
    ```

5. Migrate both the `aws_instance.from_list` and the `aws_instance.from_map` resources to use the new information when setting the subnet_id property of the created resources.

    ```
    resource "aws_instance" "from_list" {
      count         = length(var.ec2_instance_config_list)
      ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
      instance_type = var.ec2_instance_config_list[count.index].instance_type
      subnet_id     = aws_subnet.main[
        var.ec2_instance_config_list[count.index].subnet_name
      ].id

      tags = {
        Name    = "${local.project}-${count.index}"
        Project = local.project
      }
    }

    resource "aws_instance" "from_map" {
      for_each      = var.ec2_instance_config_map
      ami           = local.ami_ids[each.value.ami]
      instance_type = each.value.instance_type
      subnet_id     = aws_subnet.main[each.value.subnet_name].id

      tags = {
        Name    = "${local.project}-${each.key}"
        Project = local.project
      }
    }
    ```

6. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've taken an important step in deepening your understanding of Terraform and AWS, especially on how to manage EC2 instances and subnets. Keep up the great work as you continue to explore and learn!
