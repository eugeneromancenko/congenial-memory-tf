## Terraform
The terraform code in a modular format with the modules declared in the 
`./modules folder` 

```
.

└── modules
    ├── ecr-cluster
    └── ecs-fargate-app
└── zone
    └──prod.tfvars
```

Harcoded environment variables in the `./zone/prod.tfvars`

## State
The state file is not stored remotely. 

## Run

## CI/CD
Just Plan added into terraform repo. as state file not available for github action runners. 

## Todo
- Versioning modules
- State file stored in bucket or worspaces 
- terraform plan when PR created pipeline
- terraform apply when merged pipeline
- terrafomr fmt / validatejob
- terratest unit testing or alternative -> https://terratest.gruntwork.io/docs/testing-best-practices/alternative-testing-tools/
- using vpc public / private subnets 


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | ./modules/ecs-cluster | n/a |
| <a name="module_ecs_fargate_app"></a> [ecs\_fargate\_app](#module\_ecs\_fargate\_app) | ./modules/ecs-fargate-app | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_subnets.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to use | `string` | `"eu-west-3"` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `any` | n/a | yes |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | n/a | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | value | `string` | `"congenial-memory"` | no |

## Outputs

No outputs.