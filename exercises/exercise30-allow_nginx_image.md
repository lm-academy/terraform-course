# Extending the AMIs to also Allow NGINX

## Introduction

In this exercise, we will extend the Amazon Machine Images (AMIs) to include NGINX, a popular open-source web server. This will involve defining a data source for the NGINX Bitnami AMI, extending the `ami_ids` local to include an entry for NGINX, and adding an object for an NGINX instance to the `ec2_instance_config_list` variable. After setting up the infrastructure, we will apply and destroy it to avoid additional costs. This exercise will provide valuable practice in managing complex configurations and manipulating data sources and resources in Terraform.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Define a data source to fetch the AMI ID for the NGINX Bitnami AMI.
2. Extend the `ami_ids` local to include an entry for NGINX.
3. Add another object in the `ec2_instance_config_list` to deploy an instance with the NGINX image.

## Step-by-Step Guide

1. Start by defining a data source for the NGINX Bitnami AMI. The structure is similar to the one from ubuntu, but we need to change its name. Where can we find this information? (Hint: Check the AWS console, we can use the same method as we did in the past to find the AMI ID, but now we should look for the AMI name).

    ```
    data "aws_ami" "nginx" {
      most_recent = true

      filter {
        name   = "name"
        values = ["bitnami-nginx-1.25.4-*-linux-debian-12-x86_64-hvm-ebs-*"]
      }

      filter {
        name   = "virtualization-type"
        values = ["hvm"]
      }
    }
    ```

2. Extend our `ami_ids` local to include an entry for nginx.

    ```
    locals {
      ami_ids = {
        ubuntu = data.aws_ami.ubuntu.id
        nginx  = data.aws_ami.nginx.id
      }
    }
    ```

3. Now extend our `ec2_instance_config_list` variable to include another object for an NGINX instance.

    ```
    ec2_instance_config_list = [
      {
        instance_type = "t2.micro",
        ami           = "ubuntu"
      },
      {
        instance_type = "t2.micro",
        ami           = "nginx"
      }
    ]
    ```

4. Run a `terraform apply` command and inspect the changes. Wasn’t it easy to create extend our configuration without having to touch the `aws_instance.from_list` resource? This points towards a well-designed code!
5. Make sure to destroy the resources after you complete all the steps!

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've successfully learned how to create multiple EC2 instances based on a list in Terraform. This is a significant step forward in managing complex configurations and manipulating data sources and resources in Terraform. Keep up the good work!
