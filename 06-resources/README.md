Steps for implementation:

1. [DONE] Deploy a VPC and a subnet
2. [DONE] Deploy an internet gateway and associate it with the VPC
3. [DONE] Setup a route table with a route to the IGW and associate it with the subnet
4. [DONE] Deploy an EC2 instance inside of the created subnet and associate a public IP
5. [DONE] Associate a security group that allows public ingress
6. [DONE] Change the EC2 instance to use a publicly available NGINX AMI
7. [DONE] Destroy everything

---

# ⚠️ IMPORTANT! The NGINX AMI Is No Longer Available ⚠️

Welcome! Before you follow along with this section, there is one important change you need to make. The lectures use a public NGINX AMI (`ami-0dfee6e7eb44d480b`) that came with NGINX already installed and running. That AMI has since been removed from AWS, so if you run `terraform apply` with it, the deployment will fail.

The good news: the fix is small, and it actually teaches you a more realistic pattern. Instead of relying on a pre-built image, we will deploy a plain **Ubuntu** instance and install NGINX ourselves when the instance first boots, using a `user_data` script. This is exactly how you would provision servers in the real world, so this is a change worth understanding rather than just copying.

**Please bear with me** for a little while: I am recording and uploading an updated version of the upcoming lecture to reflect these changes. In the meantime, this guide has everything you need to keep moving. Thanks for your patience!

A quick heads-up: these changes mostly make the concrete hands-on steps of the upcoming lecture (Deploying an NGINX instance) unnecessary, since you will already have done them here. It is still very much worth watching that lecture, though, as it includes useful discussions that go beyond the steps themselves.

Let's walk through it.

## Step 1: Swap the AMI to Ubuntu

Open `compute.tf` and find the `aws_instance.web` resource. The first thing to change is the `ami` value, from the old NGINX image to a generic Ubuntu image.

**Before:**

```hcl
ami = "ami-0dfee6e7eb44d480b"
```

**After:**

```hcl
ami = "ami-0652a081025ec9fee"
```

A quick but important note: **AMI IDs are region-specific**. The ID above is valid for the course region (`eu-west-1`). If you are deploying to a different region, this exact ID will not exist there, and you will need to look up the correct Ubuntu AMI ID for your own region.

## Step 2: Install NGINX at boot with a user_data script

A plain Ubuntu instance does not have NGINX on it, so we need to install it ourselves. We do this with a `user_data` script, a block of shell commands that AWS runs automatically the first time the instance boots.

Still inside the `aws_instance.web` resource, add the following:

```hcl
user_data = <<-EOF
            #!/bin/bash
            apt-get update -y
            apt-get install -y nginx
            systemctl enable nginx
            systemctl start nginx
            EOF
```

Let's break this down:

- `apt-get update -y` refreshes the list of available packages.
- `apt-get install -y nginx` downloads and installs NGINX.
- `systemctl enable nginx` makes NGINX start automatically on future reboots.
- `systemctl start nginx` starts NGINX right now, so it is serving immediately.

## Step 3: Add an outbound (egress) rule to the security group

This is the step most people miss, and it is the one that will silently break everything if you skip it.

Look at the security group in `compute.tf`: it only defines **ingress** (inbound) rules for ports 80 and 443. You might expect the instance to still have outbound internet access by default, but here is the catch: when you create a security group with the `aws_security_group` resource, **Terraform removes AWS's default "allow all outbound" rule** and manages egress explicitly. With no egress rule defined, your instance has **zero outbound connectivity**.

Why does that matter? Because the `user_data` script from Step 2 needs to reach the internet to download NGINX. With no outbound access, `apt-get install` fails, NGINX never gets installed, and nothing ever listens on port 80. The instance launches successfully, but the page never loads, which is a very confusing thing to debug.

To fix it, add this egress rule to `compute.tf`:

```hcl
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
```

The `ip_protocol = "-1"` means "all protocols," so this allows the instance to make outbound connections anywhere, which is what it needs to reach the Ubuntu package repositories.

## Step 4: Re-create the EC2 instance

Since you already have an instance running from the previous lecture, you need to **re-create it** so the `user_data` script runs on a fresh boot. Do this in one of two ways:

- **Recreate just the instance:** `terraform apply -replace="aws_instance.web"`
- **Or destroy and re-apply everything:** `terraform destroy` followed by `terraform apply`

Give the new instance a moment after it launches, since the `apt-get install` needs a little time to finish before NGINX starts responding.

## Step 5: Verify that NGINX is running

To confirm everything worked, grab the instance's public IP from the AWS Console (or your Terraform output) and open it in your browser:

```
http://<public-ip>
```

Make sure you use `http://` and not `https://`, since we are only serving on port 80. You should see the default "Welcome to nginx!" page.

If the page does not load right away, don't worry. **It can take up to 5 minutes** after the instance launches for the `user_data` script to finish downloading and starting NGINX. Give it a little time, then refresh the page.

---

That's it! You now have a plain Ubuntu instance that installs and runs NGINX entirely through your Terraform configuration, with no dependency on a vendor-provided image that could disappear. When you are finished experimenting, don't forget to tear everything down with `terraform destroy` so you are not billed for resources you are not using.
