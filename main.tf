################### Modules #####################

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "ecs_cluster" {
  source = "./modules/ecs-cluster"

  cluster_name = "${var.project}-cluster"
}

module "ecs_fargate_app" {
  source = "./modules/ecs-fargate-app"

  project        = var.project
  env            = var.env
  aws_region     = var.aws_region
  aws_account_id = var.aws_account_id
  image_tag      = var.image_tag
  ecs_cluster    = module.ecs_cluster.cluster_arn
  subnets        = data.aws_subnets.subnet.ids
  vpc_id         = data.aws_vpc.default_vpc.id
  host_container_port = var.host_container_port
}

################### Data #####################

data "aws_vpc" "default_vpc" {
  default = true
}

# The aws_subnet_ids data source has been deprecated and will be removed in a future version. Use the aws_subnets data source instead: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets
data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}
