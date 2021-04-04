locals {
  env               = terraform.workspace
  cidr              = lookup(var.cidrs, local.env)
  service_full_name = "${var.project_name}-${var.service_name}-${local.env}"
}

