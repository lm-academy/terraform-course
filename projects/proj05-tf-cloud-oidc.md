# Enabling OIDC for AWS Authentication from Terraform Cloud

This project focuses on enabling OpenID Connect (OIDC) for AWS authentication from Terraform Cloud. The main objective is to create and manage AWS resources, including an Identity Provider of type Web Identity and a role named `terraform-cloud-automation-admin`, and then import them into Terraform. The project will guide you through the process of setting up the Identity Provider with specific URL and Client ID information, connecting the created role to the Identity Provider, and configuring the Trust Relationship of the role to restrict the subject to a single Terraform Cloud project and workspace.

## Desired Outcome

1. We will start with manually creating some resources in AWS, and then we will import them into Terraform.
2. Create an Identity Provider in AWS of type Web Identity. Provide the following information:
    1. URL: `https://app.terraform.io`
    2. Client ID / Audience: `aws.workload.identity`
3. Create a role `terraform-cloud-automation-admin` in AWS and connect it to the created identity provider, so that it can be assumed through that provider.
4. Configure the Trust Relationship of the role to restrict the subject to a single Terraform Cloud project and workspace.
    1. **Hint:** You can set this in the role by adding the following block under `Condition` in the Trust relationships tab and substituting the values for `TF-CLOUD-ORG`, `TF-CLOUD-PROJ` and `TF-CLOUD-WORKSPACE` respectively.
        ```
        "StringLike": {
            "app.terraform.io:sub": [
                "organization:TF-CLOUD-ORG:project:TF-CLOUD-PROJ:workspace:TF-CLOUD-WORKSPACE:run_phase:*"
            ]
        }
        ```
5. Attach an admin policy to the created role.
6. In Terraform Cloud, create a new project and workspace with the same name that you have specified above.
7. In Terraform Cloud, enable OIDC authentication for the created workspace.
8. Make sure that the workspace can connect to AWS by creating a dummy S3 bucket.
9. Once everything is working, import the created AWS resources into Terraform.
10. Extend the setup to allow a second workspace to assume the role. How can we leverage what we have learned so far to create a well-designed, DRY solution?
11. Make sure to delete all the resources at the end of the project!
