# Creating a VPC and Subnet via VCS Integration

## Introduction

In this exercise, we will guide you step-by-step through the process of creating a Virtual Private Cloud (VPC) and a Subnet using VCS Integration. We will be using the repository from the previous exercise, modifying it to work with our new configuration. We'll also guide you on how to set up AWS credentials for the workspace, and how to trigger runs to verify everything is working as expected.

## Step-by-Step Guide

1. If not yet done so, create a new private repository in the GitHub account you used to login into Terraform Cloud. Clone the repository into your local machine. Make sure it’s not nested under the folder that we are using for the course code! Instead, clone it somewhere else (it can be a sibling directory, for example).
2. Create a new `provider.tf` file, and add the same configuration we have used for the terraform cloud section of our terraform repository. Remove the `random` provider, and update the workspace to match the name of the newly created one for the VCS integration.
3. Create a new `variables.tf` file, and a variable `vpc_cidr` of type string.

    ```
    variable "vpc_cidr" {
      type = string
    }
    ```

4. Create a new `networking.tf` file, and add an `aws_vpc` resource that references the created variable to define its CIDR block.

    ```
    resource "aws_vpc" "tf_cloud" {
      cidr_block = var.vpc_cidr

      tags = {
        Name = "terraform-cloud"
      }
    }
    ```

5. Add, commit, and push the changes to GitHub. Inspect whether there are any changes in the Terraform Cloud workspace.
6. Configure the `vpc_cidr` variable in the Terraform Cloud platform, and trigger a new run via the UI.
7. This will not work by default, since we have not set up AWS credentials for the newly created workspace. Set up the necessary AWS credentials as we have already done in previous exercises, and re-trigger the run via the UI. Make sure that everything is working as expected by confirming the plan and inspecting the results.
8. Return to the code and create a new variable `subnet_cidr` of type string, and a new subnet resource that references the newly created `subnet_cidr` variable. Format the code and commit the changes.

    ```
    variable "subnet_cidr" {
      type = string
    }

    resource "aws_subnet" "tf_cloud" {
      cidr_block = var.subnet_cidr
      vpc_id.    = aws_vpc.tf_cloud.id

      tags = {
        Name = "terraform-cloud"
      }
    }
    ```

9. Before pushing the code, configure the `subnet_cidr` variable to contain a suitable value. Once this is set up, push the code to GitHub.
10. Confirm that the newly pushed code triggers a run automatically, and confirm that the plan intends to create a new subnet. Apply the changes by approving the plan.

## Congratulations on Completing the Exercise!

Congratulations on successfully completing this exercise! You have learned how to create a Virtual Private Cloud (VPC) and a Subnet using VCS Integration. This is a valuable skill in cloud computing, and you should be proud of your achievement. Keep up the good work!
