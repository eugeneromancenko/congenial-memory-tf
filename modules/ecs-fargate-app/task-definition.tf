################### ECS Task Definition #####################

# Manages a revision of an ECS task definition to be used in aws_ecs_service.
resource "aws_ecs_task_definition" "this" {
  family                    = "${var.project}-family"
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = 1024
  memory                    = 2048
  execution_role_arn        = data.aws_iam_role.task_ecs.arn

  container_definitions = jsonencode([
    {
      name  = "${var.project}-app"
      image = "303981612052.dkr.ecr.${var.aws_region}.amazonaws.com/${var.project}:${var.image_tag}"


      portMappings = [
        {
          containerPort = var.host_container_port
          hostPort      = var.host_container_port
        }
      ]
    }
  ])
}

# ECS Task Execution Role
data "aws_iam_role" "task_ecs" {
  name = "ecsTaskExecutionRole"
}
