module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "${local.service_full_name}-alb-sg"
  description = "Security group for ${var.project_name}-${var.service_name} ALB in ${local.env} environment"

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"

    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"

    },
  ]

  tags = {
    Environment = local.env
    Project     = var.project_name
    Service     = var.service_name
  }
}

module "service_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name        = "${local.service_full_name}-service-sg"
  description = "Security group for ${var.project_name}-${var.service_name} in ${local.env} environment"
  vpc_id      = module.vpc.vpc_id


  ingress_with_source_security_group_id = [
    {
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      source_security_group_id = module.alb_sg.this_security_group_id
    },
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"

    },
  ]

  tags = {
    Environment = local.env
    Project     = var.project_name
    Service     = var.service_name
  }
}
