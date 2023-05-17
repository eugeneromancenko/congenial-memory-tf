################### Security Groups #####################

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

resource "aws_vpc_security_group_ingress_rule" "lb_allow_https" {
  description = "Rule to ingress traffic, allow port 443"
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "443"
  to_port     = "443"
  ip_protocol = "tcp"
}

# rule to allow app port. port 5000 for flask
resource "aws_vpc_security_group_egress_rule" "lb_allow_port" {
  description = "Rule to egress traffic, allow all"
  security_group_id = aws_security_group.lb_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  to_port     = -1
  ip_protocol = -1
}

################### Application Load Balancer #####################

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

################### Application Load Balancer Target Group #####################

# Provides a Target Group resource for use with Load Balancer resources
resource "aws_lb_target_group" "this" {
  name        = "${var.project}-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

################### Application Load Balancer Listener #####################

# Provides a Load Balancer Listener resource
resource "aws_lb_listener" "http" {
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

# ALB Listener resource
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  certificate_arn = "arn:aws:acm:eu-west-1:363747985912:certificate/17713c71-eb29-45a3-a668-f016c1beedb8"

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}