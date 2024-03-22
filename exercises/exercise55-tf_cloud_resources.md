# Creating Our First Resource with Terraform Cloud

## Introduction

In this exercise, we will create our first resource using Terraform Cloud. We will generate a new `random_id`, inspect the results of the run, and apply the run via the User Interface (UI). This exercise will provide a practical understanding of how Terraform Cloud works and the kind of information we can visualize within the platform.

## Step-by-Step Guide

1. Create a new `random_id` of `byte_length = 4`, and output the hexadecimal value as an output.

    ```
    resource "random_id" "this" {
      byte_length = 4
    }

    output "random_id" {
      value = random_id.this.hex
    }
    ```

2. Run `terraform apply` and inspect the results of the run. Before confirming on the CLI, jump to Terraform Cloud and inspect what has happened within the workflow.
3. Apply the run via the UI and check what happens in the terminal once we do that. Also inspect the changes in the UI, and which kind of information we can visualize there.

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've taken a big step in understanding how to create resources using Terraform Cloud. Keep up the good work!
