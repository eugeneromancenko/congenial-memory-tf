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
  description = "Number of instances of the task definition to place and keep running"
  type        = number
  default     = 2
}


# variable "task_family" {
#   description = "A unique task family name"
#   type        = string
#   default     = "hello"
# }

# variable "task_cpu" {
#   description = "The CPU allocation for the task in CPU units"
#   type        = number
#   default     = 256
# }

# variable "task_memory" {
#   description = "The Memory allocation for the task in MiB"
#   type        = number
#   default     = 512
# }

# variable "repository_name" {
#   description = "The repository containing the image for the hello task container"
#   type        = string
#   default     = "hello"
# }



# variable "task_container_port" {
#   description = "The port the app listens on in the container"
#   type        = number
#   default     = 5000
# }

# variable "task_host_port" {
#   description = "The port the app is exposed on the host"
#   type        = number
#   default     = 5000
# }

# variable "service_name" {
#   description = "The name for the ECS service"
#   type        = string
#   default     = "hello"
# }

# variable "instance_desired_count" {
#   description = "The desired replicas of the task to run in the service"
#   type        = number
#   default     = 2
# }

# variable "ecs_cluster" {
#   description = "The ARN of the ECS Cluster to run the service in"
#   type        = string
# }

# variable "service_subnets" {
#   description = "The subnet(s) to launch the service in"
#   type        = list(string)
# }

# variable "ecs_execution_role_policy_arn" {
#   description = "The ARN of the policy to use for the ECS task"
#   type        = string
# }



# variable "lb_subnets" {
#   description = "The subnets for the load balancer (must be public)"
#   type        = list(string)
# }