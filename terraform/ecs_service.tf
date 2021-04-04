resource "aws_ecs_service" "this" {
  name            = local.service_full_name
  cluster         = module.ecs.this_ecs_cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2

  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [module.service_sg.this_security_group_id]
  }

  launch_type = "FARGATE"

  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = local.service_full_name
    container_port   = var.host_port
  }

  tags = {
    Environment = local.env
    Project     = var.project_name
    Service     = var.service_name
  }
}
