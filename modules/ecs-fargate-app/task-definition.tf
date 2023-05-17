################### ECS Task Definition #####################

# Manages a revision of an ECS task definition to be used in aws_ecs_service.
resource "aws_ecs_task_definition" "this" {
  family                    = "${var.project}-family"
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = 1024
  memory                    = 2048
  execution_role_arn        = data.aws_iam_role.task_ecs.arn
  task_role_arn             = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "${var.project}-app"
      image = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.project}-app:${var.image_tag}"


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

# ECS Task role 
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# resource "aws_iam_role_policy_attachment" "ecs_task_role_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
#   role       = aws_iam_role.ecs_task_role.name
# }

resource "aws_iam_role_policy_attachment" "ecs_task_role_attachment" {
  policy_arn = aws_iam_policy.dynamodb_access.arn
  role       = aws_iam_role.ecs_task_role.name
}

resource "aws_iam_policy" "dynamodb_access" {
  name = "dynamodb-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "dynamodb:PutItem",
          "dynamodb:Scan"
        ]
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/*"
      }
    ]
  })
}