# Using Data Sources to Fetch AWS Caller Identity and Region

## Introduction

In this exercise, we will be focusing on understanding and utilizing the AWS Caller Identity and AWS Region Data Sources. The aim is to define data sources for both AWS Caller Identity and AWS Region. Then, we will output the returned identity of the caller and the current AWS region. It's a valuable practice to enhance your Terraform skills and familiarity with these particular aspects.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. AWS Caller Identity Data Source: This data source should be defined to return the identity of the caller.
2. AWS Region Data Source: This data source should be defined to get the current AWS region.
3. AWS Caller Identity Output: This output should return the identity of the caller.
4. AWS Region Output: This output should return the current AWS region.

## Step-by-Step Guide

1.  First, define the data source for the AWS Caller Identity. This data source is used to return the identity of the caller. This is achieved with the following code:

    ```
    data "aws_caller_identity" "current" {}
    ```

2.  Next, define the data source for the AWS Region. This data source is used to get the current region. This is done with the following code:

    ```
    data "aws_region" "current" {}
    ```

3.  Then, output the AWS Caller Identity. This will return the identity of the caller. This is done with the following code:

    ```
    output "aws_caller_identity" {
      value = data.aws_caller_identity.current
    }
    ```

    Which kind of information is retrieved through this data source?

4.  Finally, output the AWS Region. This will return the current region. This is done with the following code:

    ```
    output "aws_region" {
      value = data.aws_region.current
    }
    ```

    Which kind of information is retrieved through this data source?

## Congratulations on Completing the Exercise!

Well done on successfully completing the exercise on AWS Caller Identity and Region! You've taken another important step in enhancing your Terraform skills. Keep up the great work!
