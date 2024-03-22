# Using Data Sources to Create AWS IAM Policies

## Introduction

In this exercise, we will be creating AWS IAM Policies. IAM policies define permissions and can be attached to IAM identities or groups. Our primary objective is to create a policy that gives read access to all objects in S3 buckets for all users. This is essential for making a static website publicly accessible. We will use the `aws_iam_policy_document` data source to create our policy document. The completed policy document will be outputted in JSON format for use in other parts of the code.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create an IAM policy document using the `aws_iam_policy_document` data source. The policy should apply to all users and give read access to all objects in S3 buckets.
2. Output the policy document in JSON format for use elsewhere in the code.

## Step-by-Step Guide

1. Create an IAM policy document by leveraging the `aws_iam_policy_document` data source. This document will specify the permissions that are being granted. In our case, we're creating a policy document that allows read access to all objects in S3 buckets.

    ```
    data "aws_iam_policy_document" "static_website" {
      statement {
        sid = "PublicReadGetObject"

        principals {
          type        = "*"
          identifiers = ["*"]
        }

        actions = ["s3:GetObject"]

        resources = ["arn:aws:s3:::*/*"]
      }
    }
    ```

    In the `principals` block, we specify that the policy applies to all users (`type = "*"`) because we want the static website to be publicly accessible.

    In the `actions` block, we specify the "s3:GetObject" action. This allows users to retrieve objects from the S3 bucket.

    The `resources` block specifies the resources to which the action applies. In this case, it applies to all objects in all S3 buckets (as indicated by the `"*"` wildcard characters).

2. After defining the policy document, output it in JSON format so it can be used elsewhere in the code.

    ```
    output "iam_policy" {
      value = data.aws_iam_policy_document.static_website.json
    }
    ```

    The `value = data.aws_iam_policy_document.static_website.json` line converts the policy document into JSON format.

## Congratulations on Completing the Exercise!

Well done on successfully completing this exercise! You have now acquired the knowledge to create AWS IAM Policies, a crucial skill for managing access to resources on AWS. Keep practicing to solidify your understanding. Great job!
