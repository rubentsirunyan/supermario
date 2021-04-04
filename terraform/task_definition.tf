resource "aws_ecs_task_definition" "this" {
  family                   = local.service_full_name
  cpu                      = var.cpu
  memory                   = var.memory
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.execution_role.arn

  container_definitions = jsonencode([
    {
      name      = local.service_full_name
      image     = var.image
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
    }]
  )

  tags = {
    Environment = local.env
    Project     = var.project_name
    Service     = var.service_name
  }
}
