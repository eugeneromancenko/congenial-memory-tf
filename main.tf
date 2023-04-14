module "ecs_cluster" {
  source = "./modules/ecs-cluster"

  cluster_name = "${var.project}-cluster"
}


##############################################
################### Data #####################
##############################################

data "aws_iam_role" "task_ecs" {
  name = "ecsTaskExecutionRole"
}

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
