# Using Objects for Volume Configuration

## Introduction

In this exercise, we will delve into the use of objects for volume configuration in EC2 instances. This concept allows us to encapsulate related configuration details into a single, more manageable entity. We will also explore how to incorporate additional tags to an EC2 instance, providing us with more flexibility in managing our AWS resources. This exercise will help reinforce your understanding of Terraform variables and resources, and how they can be used to create more efficient and flexible configurations.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a variable `ec2_volume_config`, which contains the volume type and volume type of the root block device for the EC2 instance.
2. Create a variable `additional_tags`, which allows the user to define additional tags to the EC2 instance.
3. Update the EC2 instance configuration to leverage the new variables.

## Step-by-Step Guide

1. Migrate from using the `ec2_volume_type` and `ec2_volume_size` variables to using a single `ec2_volume_config` variable, which is of type `object`. Set sensible defaults and add a helpful description to the new variable.

    ```
    variable "ec2_volume_config" {
      type = object({
        size = number
        type = string
      })
      description = "The size and type of the root block volume for EC2 instances."

      default = {
        size = 10
        type = "gp3"
      }
    }
    ```

2. Add a new `additional_tags` variable, which is of type `map` of strings and is empty by default. This will allow us to add more tags to our resources if needed.

    ```
    variable "additional_tags" {
      type    = map(string)
      default = {}
    }
    ```

3. Migrate the EC2 instance resource to use the new variables.

    ```
    resource "aws_instance" "compute" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = var.ec2_instance_type

      root_block_device {
        delete_on_termination = true
        volume_size           = var.ec2_volume_config.size
        volume_type           = var.ec2_volume_config.type
      }

      tags = merge(var.additional_tags, {
        ManagedBy = "Terraform"
      })
    }
    ```

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You have successfully learned how to use variables of type `object` and `map`. Keep up the good work!
