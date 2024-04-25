# Creating an RDS Module

This project revolves around creating a reusable AWS RDS (Relational Database Service) module using Terraform. The primary objective is to automate the deployment and configuration of RDS instances, with a focus on security, modularity and reusability. The project will guide you through the process of defining module variables for various RDS configurations such as instance class, allocated storage, engine type, and credentials. It also includes the setup of subnet IDs and security groups for the RDS instance. An important aspect of this project is the addition of relevant validations for each created variable, ensuring optimal configuration and security.

## Desired Outcome

1. Create a module using the standard module structure under `modules/rds`.
    1. Feel free not to include the `main.tf` file, but make sure to add the files for variables and outputs.
2. Define module variables to receive:
    1. The project name
    2. The RDS instance class
    3. The RDS allocated storage
    4. The RDS engine
    5. The RDS credentials
    6. The subnet IDs where to deploy the RDS instance
    7. The security groups to attach to the RDS instance
3. Add relevant validations for each of the created variables. Here are some examples:
    1. Ensure that the instance class and allocated storage are within the free tier options.
    2. Ensure that the RDS credentials' password contains at least one character and one digit.
    3. Ensure that the subnets provided via the subnet IDs are not deployed in the default VPC.
    4. Ensure that the subnets provided via the subnet IDs are marked as private.
    5. Ensure that the security groups provided via the security group IDs do not allow inbound traffic from IP CIDR blocks.
4. Outside of the module, create the necessary resources:
    1. Custom VPC and subnets
    2. Security groups and their respective rules
5. Make sure that the validation is working by creating both compliant and non-compliant resources, and passing them as input variables when calling the module.
6. Add an `aws_db_instance` resource inside the module and deploy it by running `terraform apply`.
7. Make sure to delete all the resources at the end of the project!
