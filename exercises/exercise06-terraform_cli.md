# Working with the Terraform CLI

## Introduction

Welcome to this exercise on the Terraform Command Line Interface (CLI)! This hands-on activity will guide you through the essential Terraform commands. You'll learn how to validate your files, format them for better readability, create and apply execution plans, and manage your state. Let's dive in and explore these powerful tools.

## Step-by-Step Guide

Run the following commands in the terminal and inspect their output. To learn more about each command, try adding a `-help` flag to the command!

-   `terraform validate`: Checks the syntax of the Terraform files and verifies that they are internally consistent, but does not ensure that the resources exist or that the providers are properly configured.
-   `terraform fmt`: Automatically updates Terraform configuration files to a canonical format and style, improving consistency and readability. The command works only for the files in the current working directory, but you can also add a `-recursive` flag to format `.tf` files in nested directories.
-   `terraform plan`: Creates an execution plan, showing what actions Terraform will take to achieve the desired state defined in the Terraform files. This command does not modify the actual resources or state.
-   `terraform plan -out <filename>`: Similar to `terraform plan`, but it also writes the execution plan to a file that can be used by `terraform apply`, ensuring that exactly the planned actions are taken.
-   `terraform apply`: Applies the execution plan, making the necessary changes to reach the desired state of the resources. If you run `terraform plan` with the `-out` option, you can run `terraform apply <filename>` to provide the execution plan.
-   `terraform show`: Provides human-readable output from a state or plan file. It's used to inspect the current state or to see the actions planned by a `terraform plan` command.
-   `terraform state list`: Lists all resources in the state file, useful for managing and manipulating the state.
-   `terraform destroy`: Destroys all resources tracked in the state file. This command is the equivalent of passing a `-destroy` flag to the `terraform apply` command.
-   `terraform -help`: Provides help information about Terraform commands. It can be used alone for a general overview, or appended to a specific command for detailed help about that command.

## Congratulations on Completing the Exercise!

Great job on completing this exercise on Terraform CLI! You've taken a significant step in mastering Terraform, and we hope that this knowledge serves you well in your future projects. Keep up the good work!
