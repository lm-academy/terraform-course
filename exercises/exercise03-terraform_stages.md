# Understanding the Different Terraform Stages

## Introduction

In this exercise, we aim to learn about the different stages of Terraform. We'll go through the process of initializing our working directory, planning and applying our configuration, and finally, destroying the infrastructure when it's no longer needed. This hands-on experience will provide an understanding of the practical benefits and the lifecycle of IAC.

## Step-by-Step Guide

Make sure you are in the `01-benefits-iac`directory and run the following commands, always taking a break to analyze and understand the output of the commands.

1. Use the `terraform init` command to initialize your working directory. This command prepares your directory for other Terraform commands and ensures that Terraform has everything it needs to run.
2. Use `terraform plan` to create an execution plan. This command determines what actions are necessary to achieve the desired state specified in your configuration files.
3. Once you're satisfied with the plan, apply it using `terraform apply`. This command will make the necessary changes to reach the desired state of your configuration.
4. When you no longer need the infrastructure, you can use `terraform destroy` to remove all resources created by your Terraform configuration. This will also clean up the state.

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've now gained hands-on experience with the different stages of Terraform and have a better understanding of Infrastructure as Code. Keep up the good work!
