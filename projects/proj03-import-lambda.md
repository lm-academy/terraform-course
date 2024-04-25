# Importing Lambda Resources into Terraform

This project focuses on importing existing AWS resources into Terraform. The primary goal is to learn how to use code generation features from Terraform to help us import several infrastructure components. The project will guide you through the process of creating, importing, and managing Lambda functions. It's important to note that all resources created during this project should be deleted at the end to avoid unnecessary costs.

## Desired Outcome

1. Create a Lambda function manually in the AWS console.
    1. Use the hello-world blueprint.
    2. For the execution role, select the "Create a new role with basic permissions" option.
2. Identify all the resources that were created when creating the Lambda function.
3. Import the Lambda function and its code into Terraform.
    1. **Hint:** Lambda function code can be provided via a ZIP file. Terraform offers ZIP file management via the `archive` provider.
4. Import the other created resources into Terraform.
5. Use as much configuration generation as possible, always keeping in mind that the generated code should be first refined before being definitely added to the project.
6. Make sure to delete all the resources at the end of the project!
