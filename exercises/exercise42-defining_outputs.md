# Defining Our Module’s Outputs

## Introduction

In this exercise, we will be defining the outputs for our module. This is a crucial step in Terraform module development, as it allows us to expose certain values that can be used by other resources or modules. We will focus on creating outputs for the VPC ID, public subnets, and private subnets. This will include the creation of a new `vpc_id` module output and two new outputs, `public_subnets` and `private_subnets`. Detailed instructions will guide you through the process, helping you understand how to create and utilize these outputs effectively.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a new `vpc_id` module output that exposes the VPC ID of the created VPC.
2. Define two new outputs, `public_subnets` and `private_subnets`, to expose the `subnet_id` and the `availability_zone` for each of the provided subnets.

## Step-by-Step Guide

1. Create a new `vpc_id` module output, which exposes the VPC ID of the created VPC. Add a relevant description to the created output.

    ```
    output "vpc_id" {
      description = "The AWS ID from the created VPC"
      value       = aws_vpc.this.id
    }
    ```

2. Create two new outputs, `public_subnets` and `private_subnets`, which expose the following information for each of the provided subnets:

    1. `subnet_id`, which contains the ID of the created subnet.
    2. `availability_zone`, which contains the AZ of the created subnet.

    Use the keys provided by the user in the `subnet_config` variable to organize the output map. This will allow users to easily retrieve information for a specific subnet based on the keys they have provided. Keep the code clean by:

    1. Introducing locals for parsing values instead of providing inline `for` loops.
    2. Providing a description for each of the created outputs.

    ```

    locals {
      output_public_subnets = {
        for key in keys(local.public_subnets) : key => {
          subnet_id         = aws_subnet.this[key].id
          availability_zone = aws_subnet.this[key].availability_zone
        }
      }

      output_private_subnets = {
        for key in keys(local.private_subnets) : key => {
          subnet_id         = aws_subnet.this[key].id
          availability_zone = aws_subnet.this[key].availability_zone
        }
      }
    }

    output "public_subnets" {
      description = "The ID and the availability zone of public subnets."
      value       = local.output_public_subnets
    }

    output "private_subnets" {
      description = "The ID and the availability zone of private subnets."
      value       = local.output_private_subnets
    }
    ```

3. In the root configuration, create a couple of outputs to visualize the values we are receiving from the module.

    ```
    output "module_vpc_id" {
      value = module.vpc.vpc_id
    }

    output "module_public_subnets" {
      value = module.vpc.public_subnets
    }

    output "module_private_subnets" {
      value = module.vpc.private_subnets
    }
    ```

4. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've taken an important step in module implementation by defining the outputs for your module. Remember, we're not done yet! In the next few exercises, we will continue to implement this module. Keep up the good work!
