# Cleaning Up Resources in Terraform Cloud

## Introduction

In this exercise, we will be walking through the process of cleaning up resources in Terraform Cloud. A step-by-step guide will instruct you on how to navigate the workspace settings, queue and confirm destruction plans, check for tracked resources, and delete workspaces and modules. This guide will ensure that you efficiently and effectively manage your resources in Terraform Cloud.

## Step-by-Step Guide

1. Head over to Terraform Cloud, and navigate to the `terraform-vcs` workspace.
2. Click on “Settings” → “Destruction and Deletion”
3. Click on “Queue Destroy Plan”, and confirm it once the plan has completed.
4. Navigate to the home page of Terraform Cloud, and then navigate to the `terraform-cli` workspace.
5. Confirm that there are no resources tracked under this workspace, and delete the workspace by accessing “Settings” → “Destruction and Deletion”.
6. Navigate back to the `terraform-vcs` workspace and delete it as well.
7. Finally, navigate to the Registry page, select the published module, and then click on “Manage module for organization” and then on “Delete module”. Delete all providers and versions for the module, and confirm the deletion.

## Congratulations on Completing the Exercise!

Well done! You have successfully completed this exercise. You now know how to clean up resources in Terraform Cloud. Keep up the great work!
