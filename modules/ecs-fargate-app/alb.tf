# Provides a security group resource to allow http traffic
resource "aws_security_group" "lb_sg" {
  name    = "${var.project}-lb-sg"
  vpc_id  = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_http" {
  description = "Rule to ingress traffic, allow port 80"
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "80"
  to_port     = "80"
  ip_protocol = "tcp"
}

# rule to allow app port. port 5000 for flask
resource "aws_vpc_security_group_egress_rule" "lb_allow_port" {
  description = "Rule to egress traffic, allow all"
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  to_port     = 0
  ip_protocol = -1
}

# Provides a Load Balancer resource for app
resource "aws_lb" "this" {
  name = "${var.project}-lb"
  internal  = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb_sg.id]
  subnets = var.subnets

  tags = {
    Environment = var.env
  }
}

# Provides a Target Group resource for use with Load Balancer resources
resource "aws_lb_target_group" "this" {
  name        = "${var.project}-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

# Provides a Load Balancer Listener resource
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    #  ARN of the Target Group to which to route traffic
    target_group_arn  = aws_lb_target_group.this.arn
    #  Type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc
    type              = "forward"
  }
}