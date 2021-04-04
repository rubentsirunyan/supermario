module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "${var.project_name}-${local.env}"

  cidr = local.cidr

  azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  public_subnets = [
    cidrsubnet(local.cidr, 8, 1),
    cidrsubnet(local.cidr, 8, 2),
    cidrsubnet(local.cidr, 8, 3)
  ]
  public_subnet_tags = {
    Role = "public"
  }

  private_subnets = [
    cidrsubnet(local.cidr, 8, 11),
    cidrsubnet(local.cidr, 8, 12),
    cidrsubnet(local.cidr, 8, 13)
  ]
  private_subnet_tags = {
    Role = "private"
  }

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = local.env
    Project     = var.project_name
  }

  vpc_tags = {
    Name = "${var.project_name}-${local.env}"
  }
}
