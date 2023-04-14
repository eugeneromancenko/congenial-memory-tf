# Use the latest version of Terraform and provider plugins: 
# Keeping up to date with the latest versions of Terraform and provider plugins helps 
# ensure that you have access to the latest features, bug fixes, and security updates.
terraform {
  required_version = "~> 1.4" # version constraint for terraform 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.63" # version constraint for provider plugin
    }
  }
}

provider "aws" {
  region = var.aws_region
}