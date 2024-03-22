# Postcondition Blocks

## Introduction

In this exercise, you will learn how to replace a precondition block with a postcondition block that references the `self.instance_type` property of the EC2 instance. You will also create a second postcondition block intended to fail, create a new subnet within the default VPC, and add a `create_before_destroy = true` lifecycle property to the `aws_instance`. Finally, you will update the postcondition check to ensure that the subnet’s availability zone is contained in the list of valid availability zone names. This exercise will help you understand how to use postcondition blocks effectively in Terraform.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Replace the precondition block with a postcondition block that references the `self.instance_type` property of the EC2 instance instead of the provided variable.
2. Create a new subnet within the default VPC and with a CIDR block set to `172.31.128.0/24`.
3. Add a `create_before_destroy = true` lifecycle property to the `aws_instance`.
4. Update the postcondition check to ensure that the subnet’s availability zone is contained in the list of valid availability zone names.
5. Make sure that everything is working by running `terraform apply` and confirming that the operations successfully complete.

## Step-by-Step Guide

1. Make sure that the EC2 instance is not created. If you created it in the previous exercise, make sure to delete it. Remove the precondition block we created in the previous lecture, and replace it with a postcondition block that references the `self.instance_type` property of the EC2 instance.

    ```
    resource "aws_instance" "this" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = var.instance_type

      root_block_device {
        delete_on_termination = true
        volume_size           = 10
        volume_type           = "gp3"
      }

      lifecycle {
        postcondition {
          condition     = contains(local.allowed_instance_types, self.instance_type)
          error_message = "Self invalid instance type"
        }
      }
    }
    ```

2. Add a second postcondition block with the condition set to `self.availability_zone == "eu-central-1a"`. If you are using the `eu-central-1` region, use another value for the availability zone. This is on purpose, as this postcondition block should fail. Run a `terraform plan` and inspect whether there are any errors. Why were there no errors? Now run the `terraform apply` command and confirm the operation. What happened?

    ```
    resource "aws_instance" "this" {
      ami           = data.aws_ami.ubuntu.id
      instance_type = var.instance_type

      root_block_device {
        delete_on_termination = true
        volume_size           = 10
        volume_type           = "gp3"
      }

      lifecycle {
        postcondition {
          condition     = contains(local.allowed_instance_types, self.instance_type)
          error_message = "Self invalid instance type"
        }
      }
    }
    ```

3. Fetch the default VPC for the configured region by using an `aws_vpc` data source.

    ```
    data "aws_vpc" "default" {
      default = true
    }
    ```

4. Create a new subnet using the VPC data we have fetched. Set the CIDR block to `172.31.128.0/24`. Additionally, move the postcondition check that contains the availability zone check to this newly created subnet, and explicitly set the `subnet_id` in the `aws_instance` resource to reference this newly created subnet.

    ```
    resource "aws_subnet" "this" {
      vpc_id     = data.aws_vpc.default.id
      cidr_block = "172.31.128.0/24"

      lifecycle {
        postcondition {
          condition     = self.availability_zone == "eu-central-1a"
          error_message = "Invalid AZ"
        }
      }
    }
    ```

5. Add a `create_before_destroy = true` lifecycle property to the `aws_instance` we have created. This will make sure that new instances are created before old ones are destroyed. Run `terraform apply`, approve the changes, and inspect what will happen in the console. Which resources were created? Where did Terraform stop?
6. Now update the postcondition check to be more realistic and check whether the subnet’s availability zone is contained in the list of valid availability zone names that can be fetched via the `aws_availability_zones` data source.

    ```
    data "aws_availability_zones" "available" {
      state = "available"
    }

    resource "aws_subnet" "this" {
      vpc_id     = data.aws_vpc.default.id
      cidr_block = "172.31.128.0/24"

      lifecycle {
        postcondition {
          condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
          error_message = "Invalid AZ"
        }
      }
    }
    ```

7. Run `terraform apply` and confirm that the command goes through without any errors.
8. Make sure to destroy the infrastructure at the end of this exercise.

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've made great strides in understanding how to effectively use postcondition blocks in Terraform. Keep up the good work!
