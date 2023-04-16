# we ask you to exclusively use the eu-west-3 Paris AWS region.
variable "aws_region" {
  description = "The AWS region to use"
  type        = string
  default     = "eu-west-3"
}

variable "project" {
  description = "value"
  type        = string
  default     = "congenial-memory"
}

variable "env" {}

variable "image_tag" {}

