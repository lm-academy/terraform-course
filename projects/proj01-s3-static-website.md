# Deploying a Static Website with S3

This project is designed to provide hands-on experience with deploying a static website using Amazon S3 and Terraform. The goal is to create an S3 bucket, host files for the static website, and manage access permissions and policies. This project is a great opportunity to learn about AWS S3, Terraform, and the principles of Infrastructure as Code (IaC). Make sure to use Terraform for as many resources as possible, and remember to delete all the resources at the end of the project to avoid unnecessary costs.

## Desired Outcome

1. Deploy an S3 bucket that will host the files for the static website.
2. Create an `index.html` file and an `error.html` file containing some dummy text.
    1. **Hint:** Here is a source where you can find a [basic template](https://ryanstutorials.net/html-tutorial/html-template.php).
3. In a first moment, upload these files manually to the bucket via the AWS console. They should be placed in the root directory of the bucket. Later we will upload these files via Terraform.
4. Disable public access block so that others can access the bucket via the internet.
5. Create a policy that allows the `s3:GetObject` action for anyone and for all objects within the created bucket.
6. Create an S3 static website configuration, and link it to the existing bucket.
7. Create an output with the S3 Static Website endpoint.
8. After testing that you can access the website via the internet, let's now update the files via Terraform.
    1. Delete the files from the S3 bucket.
    2. Use Terraform to create `aws_s3_object` resources and upload the files.
9. Tag resources with useful information about your project.
10. Make sure to delete all the resources at the end of the project!
