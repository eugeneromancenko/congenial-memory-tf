# Provides an ECS service - effectively a task that is expected to run until an error occurs or a user terminates it
resource "aws_ecs_service" "this" {
  name            = "${var.project}-service"
  cluster         = var.ecs_cluster
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.instance_desired_count


  network_configuration {
    subnets           = var.subnets
    security_groups   = [aws_security_group.this.id]
    assign_public_ip  = true
  }

  load_balancer {
    target_group_arn  = aws_lb_target_group.this.arn
    container_name    = "${var.project}-container"
    container_port    = var.host_container_port
  }
}

resource "aws_security_group" "this" {
  name    = "${var.project}-sg"
  vpc_id  = var.vpc_id
}

# Manages an inbound (ingress) rule for a security group.
resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.this.id

  referenced_security_group_id = aws_security_group.lb_sg.id

  from_port   = var.host_container_port
  to_port     = var.host_container_port
  ip_protocol = "tcp"
}

# Manages an outbound (egress) rule for a security group.
resource "aws_vpc_security_group_egress_rule" "allow_https" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 0
  ip_protocol = -1
}