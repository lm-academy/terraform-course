# Adding Validation to the Map Variable

## Introduction

In this exercise, you will learn how to add validation to a map variable in Terraform. This is an important skill when working with Infrastructure as Code (IaC), as it allows you to ensure that your configurations adhere to specific rules and prevent the use of unsupported or unwanted configurations. Specifically, we will be adding validation to ensure that only `t2.micro` instances are used and that only `ubuntu` and `nginx` images are used. Let's dive in and learn more about how to add this validation!

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. If not already done so, define a variable `ec2_instance_config_map`.
    - This variable is a map of objects.
    - Each object contains `instance_type` and `ami`.
2. Add validation to ensure that only `t2.micro` instances are used.
3. Add another validation to ensure that only `ubuntu` and `nginx` images are used.

## Step-by-Step Guide

1. Make sure that the variable `ec2_instance_config_map` is defined and is of type map of objects, which each object containing `instance_type` and `ami`.

    ```
    variable "ec2_instance_config_map" {
      type = map(object({
        instance_type = string
        ami           = string
      }))
    }
    ```

2. Next, add a validation block to ensure that only `t2.micro` instances are used. The `condition` attribute uses the `alltrue` function to check if all instances in the `ec2_instance_config_map` are of type `t2.micro`. If this condition is not met, Terraform will return the error message `"Only t2.micro instances are allowed."`

    ```
    validation {
      condition = alltrue([
        for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)
      ])
      error_message = "Only t2.micro instances are allowed."
    }
    ```

3. Lastly, add another validation block to ensure that only `ubuntu` and `nginx` images are used. Again, the `condition` attribute uses the `alltrue` function to check if all `ami` in the `ec2_instance_config_map` are either `ubuntu` or `nginx`. If this condition is not met, Terraform will return a suitable error message.

    ```
    validation {
      condition = alltrue([
        for config in values(var.ec2_instance_config_map) : contains(["nginx", "ubuntu"], config.ami)
      ])
      error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
    }
    ```

4. After following these steps, your variable `ec2_instance_config_list` with the necessary validation should look like this:

    ```
    variable "ec2_instance_config_map" {
      type = map(object({
        instance_type = string
        ami           = string
        subnet_name   = optional(string, "default")
      }))

      validation {
        condition = alltrue([
          for config in values(var.ec2_instance_config_map) : contains(["t2.micro"], config.instance_type)
        ])
        error_message = "Only t2.micro instances are allowed."
      }

      validation {
        condition = alltrue([
          for config in values(var.ec2_instance_config_map) : contains(["nginx", "ubuntu"], config.ami)
        ])
        error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
      }
    }
    ```

5. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've learned how to add validation to a map variable in Terraform—an essential skill for maintaining robust and secure Infrastructure as Code configurations. Keep up the great work!
