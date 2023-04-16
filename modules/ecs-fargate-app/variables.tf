variable "project" {}

variable "env" {}

variable "aws_region" {}

variable "image_tag" {
  description = "Docker Image Tag"
  type        = string
}

variable "ecs_cluster" {
  description = "ARN of fargate cluster"
  type        = string
}

variable "subnets" {
  description = "subnet"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC"
  type        = string
}

variable "host_container_port" {
  description = "host/container port"
  type        = number
  default     = 5000
}

variable "instance_desired_count" {
  description = "Number of instances"
  type        = number
  default     = 2
}