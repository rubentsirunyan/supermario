module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "2.8.0"

  name = "${var.project_name}-${local.env}"

  container_insights = true

  tags = {
    Environment = local.env
    Project     = var.project_name
  }
}
