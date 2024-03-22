# Generating Speculative Plans for Pull Requests

## Introduction

This exercise will guide you through the process of creating speculative plans for pull requests in Terraform Cloud. Speculative plans are dry runs that provide a preview of what would happen if you apply a proposed change. You will learn how to trigger and visualize a speculative plan by creating and committing to a new branch, then creating a pull request.

## Step-by-Step Guide

1. In the repository we have created for our VCS integration, create a new `s3.tf` file, and create a new S3 bucket.
2. Instead of committing to the main branch, create a new branch and commit the code in this new branch. Push the changes to the respective remote branch.
3. Open the GitHub repository, and create a pull request from the new branch into the main branch. This will trigger a speculative plan, and we can visualize that by expanding the “checks” section of our pull request, and by clicking on “Details” next to the Terraform Cloud check.
4. Inspect the run details, and make sure that the run cannot be applied, since it’s a speculative plan.
5. Return to GitHub and merge the pull request. Return to Terraform Cloud, and confirm that a new run was triggered after merging the pull request. This run can now be applied, since it was not triggered from a pull request.

## Congratulations on Completing the Exercise!

Great job on completing this exercise! Your understanding of speculative plans in Terraform Cloud has taken a big step forward. Keep up the good work!
