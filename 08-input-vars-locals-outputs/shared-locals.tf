locals {
  project       = "08-input-vars-locals-outputs"
  project_owner = "terraform-course"
  cost_center   = "1234"
  managed_by    = "Terraform"
}

locals {
  common_tags = {
    project       = local.project
    project_owner = local.project_owner
    cost_center   = local.cost_center
    managed_by    = local.managed_by
    sensitive_tag = var.my_sensitive_value
  }
}