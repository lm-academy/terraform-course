# Check Blocks

## Introduction

This exercise will guide you through the process of creating and implementing `check` blocks in Terraform. You will learn how to create checks that generate warnings for missing tags on your AWS instances and ensure high availability by distributing subnets across multiple Availability Zones. Follow the step-by-step instructions, and by the end of this exercise, you will have a better understanding of how to enforce best practices and avoid common mistakes in your Terraform scripts.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a check that generates a warning when our `aws_instance` does not have a `CostCenter` tag.
2. Extend the `aws_instance` resource with the relevant `CostCenter` tag and make sure that the warning is not shown anymore.
3. Refactor the `aws_subnet` resource to create two subnets. Hard-code the AZ to a single, valid value.
4. Create a `check` block to verify that the subnets are distributed across more than one Availability Zone (AZ).
5. Migrate the `aws_subnet` resource to adopt a round-robin strategy to select the availability zone.
6. Make sure that the warning messages are not shown anymore.

## Step-by-Step Guide

1. Let’s create a check that generates a warning when our `aws_instance` does not have an important tag. Start by adding a `check` block with an assertion that verifies that the `CostCenter` tag is different than an empty string. Also account for the possibility of having null values. (Hint: the `can` function can be useful as a wrapper).

    ```
    check "cost_center_check" {
      assert {
        condition     = can(aws_instance.this.tags.CostCenter != "")
        error_message = "Your AWS Instance does not have a CostCenter tag."
      }
    }
    ```

2. Save the changes and run `terraform plan`. You should see a warning message based on the check defined above.
3. Now extend the `aws_instance` resource with the relevant CostCenter tag and run `terraform plan` once again. Verify that the warning has disappeared.

    ```
    resource "aws_instance" "this" {
      ...

      tags = {
        CostCenter = "1234"
      }

      ...
    }
    ```

4. Refactor the `aws_subnet` resource to create two subnets. Use the `count` meta-argument, and set the `availability_zone` property to a single valid value from the region you are working with (in my case, this is `eu-west-1`). You should also update the `aws_instance` resource to retrieve the subnet accordingly.

    ```
    resource "aws_subnet" "this" {
      count             = 2
      vpc_id            = data.aws_vpc.default.id
      cidr_block        = "172.31.${128 + count.index}.0/24"
      availability_zone = "eu-west-1a"

      lifecycle {
        postcondition {
          condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
          error_message = "Invalid AZ"
        }
      }
    }
    ```

5. Add a `check` block to verify that the subnets are distributed across more than one AZ. How could the condition property look like?

    ```
    check "high_availability_check" {
      assert {
        condition     = length(toset([for subnet in aws_subnet.this : subnet.availability_zone])) > 1
        error_message = <<-EOT
          You are deploying all subnets within the same AZ.
          Please consider distributing them across AZs for higher availability.
          EOT
      }
    }
    ```

6. Run `terraform plan` and verify that the warning message is shown on the screen.
7. Migrate the `aws_subnet` resource to now adopt a round-robin strategy to select the availability zone. Additionally, update the count of subnets to `4` (or `n + 1` for any region that has `n` availability zones) to make sure that the round-robin works as expected.

    ```
    data "aws_vpc" "default" {
      default = true
    }

    data "aws_availability_zones" "available" {
      state = "available"
    }

    resource "aws_subnet" "this" {
      count      = 4
      vpc_id     = data.aws_vpc.default.id
      cidr_block = "172.31.${128 + count.index}.0/24"
      availability_zone = data.aws_availability_zones.available.names[
        count.index % length(data.aws_availability_zones.available.names)
      ]

      lifecycle {
        postcondition {
          condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
          error_message = "Invalid AZ"
        }
      }
    }

    check "high_availability_check" {
      assert {
        condition     = length(toset([for subnet in aws_subnet.this : subnet.availability_zone])) > 1
        error_message = <<-EOT
          You are deploying all subnets within the same AZ.
          Please consider distributing them across AZs for higher availability.
          EOT
      }
    }
    ```

8. Re-run `terraform plan` and make sure that the warning message is not shown anymore.
9. Make sure to destroy the infrastructure before finishing this exercise.

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've taken an important step in understanding how to create and implement `check` blocks in Terraform. Keep up the good work as we continue to delve deeper into Terraform in the upcoming exercises.
