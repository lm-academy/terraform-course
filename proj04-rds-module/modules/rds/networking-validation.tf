##############################
# Subnet Validation
##############################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "input" {
  for_each = toset(var.subnet_ids)
  id       = each.value

  lifecycle {
    postcondition {
      condition     = self.vpc_id != data.aws_vpc.default.id
      error_message = <<-EOT
        The following subnet is part of the default VPC:

        Name = ${self.tags.Name}
        ID   = ${self.id}

        Please do not deploy RDS instances in the default VPC.
        EOT
    }

    postcondition {
      condition     = can(lower(self.tags.Access) == "private")
      error_message = <<-EOT
        The following subnet is not marked as private:

        Name = ${self.tags.Name}
        ID   = ${self.id}

        Please ensure that the subnet is properly tagged by adding the following tags:
        1. Access = "private"
        EOT
    }
  }
}

##############################
# Security Group Validation
##############################

data "aws_vpc_security_group_rules" "input" {
  filter {
    name   = "group-id"
    values = var.security_group_ids
  }
}

data "aws_vpc_security_group_rule" "input" {
  for_each               = toset(data.aws_vpc_security_group_rules.input.ids)
  security_group_rule_id = each.value

  lifecycle {
    postcondition {
      condition = (
        self.is_egress
        ? true
        : self.cidr_ipv4 == null
        && self.cidr_ipv6 == null
        && self.referenced_security_group_id != null
      )
      error_message = <<-EOT
      The following security group contains an invalid inbound rule:

      ID = ${self.security_group_id}

      Please ensure that the following conditions are met:
      1. Rules must not allow inbound traffic from IP CIDR blocks, only from other security groups.
      EOT
    }
  }
}