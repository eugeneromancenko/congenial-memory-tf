################### ECS Service #####################

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
    container_name    = "${var.project}-app"
    container_port    = var.host_container_port
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [task_definition]
  }

}

################### Security Groups #####################

resource "aws_security_group" "this" {
  name    = "${var.project}-sg"
  description = "Security group for ${var.project} instances"
  vpc_id  = var.vpc_id
}

# Manages an inbound (ingress) rule for a security group.
resource "aws_vpc_security_group_ingress_rule" "allow_ingress" {
  description = "Rule for ${var.project} ingress"
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = var.host_container_port
  to_port     = var.host_container_port
  ip_protocol = "tcp"
}

# Manages an outbound (egress) rule for a security group.
resource "aws_vpc_security_group_egress_rule" "allow_egress" {
  description = "Rule for ${var.project} egress"
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  to_port     = -1
  ip_protocol = -1
}