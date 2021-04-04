module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "5.12.0"

  name = "${local.service_full_name}-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_sg.this_security_group_id]
  internal        = false

  target_groups = [
    {
      name             = "${local.service_full_name}-tg"
      backend_protocol = "HTTP"
      backend_port     = var.host_port
      target_type      = "ip"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = local.env
    Project     = var.project_name
    Service     = var.service_name
  }
}

resource "null_resource" "ansible_smoke_test" {
  depends_on = [module.alb]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "ansible-playbook ${path.root}/../ansible/smoke_test.yml --extra-vars \"endpoint=http://${module.alb.this_lb_dns_name}/\""
  }
}
