# Creating VPCs and Subnets Manually in AWS

## Introduction

In this exercise, we will focus on manually building a simple VPC-subnet infrastructure on the AWS Console. This includes creating a VPC, two subnets (one public and one private), an Internet Gateway, and a public route table. By creating these elements manually, we will gain a deeper understanding of how intricate and challenging the process of creating and managing infrastructure can be. This will provide a foundation for appreciating the benefits of Infrastructure as Code (IaC) in automating these tasks and maintaining consistency across environments.

## Desired Outcome

If you wish to give it a shot before looking at the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. A VPC with a CIDR block of `10.0.0.0/16`.
2. One public subnet with a CIDR block of `10.0.0.0/24`.
3. One private subnet with a CIDR block of `10.0.1.0/24`.
4. One Internet Gateway.
5. One public route table with a route to the Internet Gateway, and the correct association between the public subnet and the public route table.

## Step-by-Step Guide

1. Login to your AWS console.
2. Navigate to the VPC Dashboard.
3. Click on "Your VPCs" then "Create VPC".
4. Enter a Name tag and the CIDR block `10.0.0.0/16` then click "Create".
5. Go back to the VPC Dashboard and click on "Subnets".
6. Click "Create subnet".
7. Fill in the Name tag, select the VPC you just created, and enter the CIDR block `10.0.0.0/24` to create the public subnet.
8. Repeat this process with the CIDR block `10.0.1.0/24` to create the private subnet.
9. Go back to the VPC Dashboard and click on "Internet Gateways".
10. Click "Create internet gateway", give it a Name tag, then click "Create".
11. Select the Internet Gateway you just created and click "Actions", then "Attach to VPC", and select your VPC.
12. Go back to the VPC Dashboard and click on "Route Tables".
13. Click "Create route table", enter a Name tag, select your VPC, then click "Create".
14. Select the Route Table you just created and click on the "Routes" tab, then click "Edit routes".
15. Click "Add route", for the Destination enter `0.0.0.0/0`, for the Target select the Internet Gateway you created, then click "Save routes".
16. Click on the "Subnet Associations" tab, then click "Edit subnet associations".
17. Select the public subnet, then click "Save".

## Congratulations on Completing the Exercise!

Congratulations on successfully completing this challenging exercise! You've manually built a VPC-subnet infrastructure on the AWS Console, and this hands-on experience has given you valuable insight into the process and complexity of creating and managing infrastructure. We hope this exercise has helped you appreciate the benefits of Infrastructure as Code (IaC) in automating these tasks and maintaining consistency across environments. Keep up the great work!
