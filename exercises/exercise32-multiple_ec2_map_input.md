# Creating EC2 Instances Based on a Map Variable

## Introduction

In this exercise, we will learn how to manage multiple EC2 instances with unique configurations using a map object in Terraform. This is a crucial skill for managing complex Terraform projects and ensuring that your infrastructure is flexible and easily configurable. We will create a map variable to hold the configuration for each EC2 instance, and then use a `for_each` loop to iterate over each item in the map and create an EC2 instance with the provided configuration. Let's dive in!

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a Terraform variable named `ec2_instance_config_map`, which holds the configuration for the EC2 instances. This map object includes `instance_type` and `ami` as keys, both of which are strings.
2. Add suitable entries to the `ec2_instance_config_map` variable in the `terraform.tfvars` file. For example, one entry could be for a `ubuntu_1` instance with `t2.micro` as the `instance_type` and `ubuntu` as the `ami`.
3. Create EC2 instances based on the `ec2_instance_config_map` variable using a `for_each` loop. This loop iterates over each item in the `ec2_instance_config_map` and creates an EC2 instance with the provided configuration.

## Step-by-Step Guide

1. Define a Terraform variable named `ec2_instance_config_map` that will hold the configuration for the EC2 instances. This will be a map object with `instance_type` and `ami` as keys, both of type `string`.

    ```
    variable "ec2_instance_config_map" {
      type = map(object({
        instance_type = string
        ami           = string
      }))
    }
    ```

2. In your `terraform.tfvars` file, add a new entry for the `ec2_instance_config_map` variable you have just created. Add some meaningful values, keeping the free tier in mind.

    ```
    ec2_instance_config_map = {
      ubuntu_1 = {
        instance_type = "t2.micro"
        ami           = "ubuntu"
      }

      nginx_1 = {
        instance_type = "t2.micro"
        ami           = "nginx"
      }
    }
    ```

3. Also, change the `ec2_instance_config_list` variable to hold an empty list so that we do not create any additional instances from the list.
4. After the variable is defined and its value specified in the `terraform.tfvars` file, you can reference it in a resource block to create EC2 instances. Use a `for_each` loop to iterate over each item in the `ec2_instance_config_map` and create an EC2 instance with the provided configuration.

    ```
    resource "aws_instance" "from_map" {
      for_each      = var.ec2_instance_config_map
      ami           = local.ami_ids[each.value.ami]
      instance_type = each.value.instance_type
      subnet_id     = aws_subnet.main[0].id

      tags = {
        Name    = "${local.project}-${each.key}"
        Project = local.project
      }
    }
    ```

    In this block, `for_each` is used to iterate over the `ec2_instance_config_map`, creating an EC2 instance for each item. The `ami` and `instance_type` parameters are set using the respective keys in the map. The `subnet_id` is hard-coded to the ID of the zeroth subnet in the `aws_subnet.main` list. The `tags` attribute is used to set the name of the instance as a combination of the project name and the `key` in the map, and the project tag as the project name.

5. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've acquired a valuable skill in managing multiple EC2 instances with unique configurations using a map object in Terraform. Keep practicing and applying what you've learned to further refine your Terraform skills. Great job!
