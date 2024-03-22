# Using `.tfvars` Files to Store Workspace Configuration

## Introduction

In this exercise, we will learn how to use `.tfvars` files to store workspace-specific configuration in Terraform. We will create different `.tfvars` files for different workspaces and learn how to apply them to manage our infrastructure. This method allows for easy scalability and modification of our configuration depending on the workspace in use. This exercise will guide you through the steps to implement this strategy.

## Step-by-Step Guide

1. Define a new variable `bucket_count` of type number, which will receive the count of buckets we should deploy.
2. Create three `.tfvars` files, each one for a workspace. Make sure that the name of the file matches `<workspace name>.tf`. Define the variable in each file with the correct number of buckets we would like to deploy per workspace.

    ```
    # dev.tfvars

    bucket_count = 1

    ---

    # staging.tfvars

    bucket_count = 2

    ---

    # prod.tfvars

    bucket_count = 3
    ```

3. Run `terraform apply -var-file=$(terraform workspace show).tfvars`, which will leverage the current workspace to find the correct `.tfvars` file. You can create an alias to this command to make your life easier, since the command remains the same independently of the selected workspace.
4. Extend the configuration to accommodate a new workspace by creating a workspace named `int` and its respective `int.tfvars` file. Pass a suitable value to bucket_count, and run the terraform apply command again, making sure to pass the `-var-file` option correctly. As you can see, with this approach we can easily extend our configuration without having to touch the underlying Terraform code.

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've taken a big step towards mastering the use of `.tfvars` files for workspace-specific configuration in Terraform. Keep up the good work!
