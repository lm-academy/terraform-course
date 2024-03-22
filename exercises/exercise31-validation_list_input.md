# Adding Validation to the List Variable

## Introduction

In this exercise, we will learn how to add validation for an EC2 instance configuration list in Terraform. The focus will be on defining a variable `ec2_instance_config_list` and adding validation checks to ensure that only `t2.micro` instances and `ubuntu` or `nginx` images are used. This exercise will guide you step-by-step on how to implement these validations.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. If not already done so, define a variable `ec2_instance_config_list`.
    - This variable is a list of objects.
    - Each object contains `instance_type` and `ami`.
2. Add validation to ensure that only `t2.micro` instances are used.
3. Add another validation to ensure that only `ubuntu` and `nginx` images are allowed.

## Step-by-Step Guide

1. Make sure that the variable `ec2_instance_config_list` is defined and is of type list of objects, which each object containing `instance_type` and `ami`.

    ```
    variable "ec2_instance_config_list" {
      type = list(object({
        instance_type = string
        ami           = string
      }))

      default = []
    }
    ```

2. Next, add a validation block to ensure that only `t2.micro` instances are used. The `condition` attribute uses the `alltrue()` function to check if all instances in the `ec2_instance_config_list` are of type `t2.micro`. If this condition is not met, Terraform will return the error message `"Only t2.micro instances are allowed."`

    ```
    validation {
      condition = alltrue([
        for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
      ])
      error_message = "Only t2.micro instances are allowed."
    }
    ```

3. Lastly, add another validation block to ensure that only `ubuntu` and `nginx` images are used. Again, the `condition` attribute uses the `alltrue` function to check if all `ami` in the `ec2_instance_config_list` are either `ubuntu` or `nginx`. If this condition is not met, Terraform will return a suitable error message.

    ```
    validation {
      condition = alltrue([
        for config in var.ec2_instance_config_list : contains(["nginx", "ubuntu"], config.ami)
      ])
      error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
    }
    ```

4. After following these steps, your variable `ec2_instance_config_list` with the necessary validation should look like this:

    ```
    variable "ec2_instance_config_list" {
      type = list(object({
        instance_type = string
        ami           = string
      }))

      default = []

      validation {
        condition = alltrue([
          for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
        ])
        error_message = "Only t2.micro instances are allowed."
      }

      validation {
        condition = alltrue([
          for config in var.ec2_instance_config_list : contains(["nginx", "ubuntu"], config.ami)
        ])
        error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
      }
    }
    ```

5. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Congratulations on successfully completing this exercise! You've mastered adding validation for an EC2 instance configuration list in Terraform. This is a valuable skill that will help you ensure the correctness and reliability of your Terraform configurations. Keep up the good work!
