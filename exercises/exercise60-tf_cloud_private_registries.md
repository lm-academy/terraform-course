# Publishing Our Networking Module in a Private Registry

## Introduction

In this exercise, we will walk through the process of publishing our networking module in a private registry. This will allow us to share and reuse the code across different projects. We'll use Terraform Cloud and GitHub for this task, and we'll provide step-by-step instructions on how to publish the module, include it in Terraform projects, and move existing resources into the module.

## Step-by-Step Guide

1. Navigate to the home page of Terraform Cloud and click on “Registry” on the left-side menu.
2. Click on “Publish” and select “Module”.
3. Use the already installed GitHub App, and select the repository containing the code for our module (we have already created a repository with a networking module in a previous section, you can use that!).
4. Select “Tag” for the module publishing type, and click on “Publish module”.
5. Once the module is successfully published, you should be able to see some information on the right side of the screen regarding how to include this module in Terraform projects. Copy the code block listed under “Usage Instructions”, and head back to the new folder we have created to work with the VCS integration.
6. Add the code to create an instance of the networking module:

    ```
    module "networking-tf-course" {
      source  = "app.terraform.io/<your-tf-cloud-organization>/networking-tf-course/aws"
      version = "0.1.1"

      vpc_config = {
        cidr_block = var.vpc_cidr
        name       = "terraform-cloud"
      }

      subnet_config = {
        subnet_1 = {
          cidr_block = "10.0.0.0/24"
          az         = <any az from your region>
        }
      }
    }
    ```

7. Make sure that we use the same CIDR blocks that we have used to create the VPC and the subnet, and move the existing resources into the module with the help of moved blocks.

    ```
    moved {
      from = aws_vpc.tf_cloud
      to   = module.networking-tf-course.aws_vpc.this
    }

    moved {
      from = aws_subnet.tf_cloud
      to   = module.networking-tf-course.aws_subnet.this["subnet_1"]
    }
    ```

8. Commit the changes into a new branch named however you prefer, and push the changes to GitHub. Create a new PR and inspect the speculative plan that was triggered. Confirm that the renaming of the subnet is the only intended change.
9. Merge the PR into the main branch, wait for the new Terraform Cloud plan to finish, and approve it via the UI.

## Congratulations on Completing the Exercise!

Fantastic work on completing this exercise! You've successfully published a networking module in a private registry and have learned how to share and reuse code across different projects. This is a major stride in your journey with Terraform Cloud. Keep up the great work!
