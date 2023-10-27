provider "aws" {
  region = var.region
}

module "aws_ecr" {
   source    = "./modules/ecr"
   namespace = var.namespace
}

module "aws_vpc" {
  source    = "./modules/network/vpc"
  namespace = var.namespace
}

module "aws_subnets" {
  source              = "./modules/network/subnets"
  namespace           = var.namespace
  vpc_id              = module.aws_vpc.vpc_id
  vpc_cidr_block      = "10.0.0.0/16"
  internet_gateway_id = module.aws_vpc.internet_gateway_id
}

module "aws_sg" {
  source          = "./modules/network/sgroups"
  vpc_id          = module.aws_vpc.vpc_id
  namespace       = var.namespace
  public_subnets  = module.aws_subnets.public_subnet_ids
  private_subnets = module.aws_subnets.public_subnet_ids
}

module "aws_alb" {
  source                = "./modules/network/lbalancer"
  namespace             = var.namespace
  vpc_id                = module.aws_vpc.vpc_id
  route53_zone_id       = module.aws_dns.route53_zone_id
  public_subnets        = module.aws_subnets.public_subnet_ids
  security_group_alb_id = module.aws_sg.security_group_alb_id
}


# module "aws_bastion_host" {
#  source                         = "./modules/ec2"
#  namespace                      = var.namespace
#  public_subnet_id               = module.aws_subnets.public_subnet_ids[0]
#  security_group_bastion_host_id = module.aws_sg.security_group_bastion_host_id
# }

module "aws_iam" {
  source    = "./modules/iam"
  namespace = var.namespace
}

# module "aws_db" {
#   source               = "./modules/aws_db"
#   security_group_db_id = module.aws_sg.security_group_db_id
#   db_subnet_group_id   = module.aws_subnets.db_subnet_group_id
# }


module "aws_ecs_cluster" {
  source    = "./modules/ecs/cluster"
  namespace = var.namespace
}

module "aws_ecs_task_defenition" {
  source                      = "./modules/ecs/task_definition"
  namespace                   = var.namespace
  db_host                     = module.aws_db.db_instance_endpoint
  ecs_task_execution_role_arn = module.aws_iam.ecs_task_execution_role_arn
  ecs_task_iam_role_arn       = module.aws_iam.ecs_task_iam_role_arn
}

module "aws_launch_template" {
  source                        = "./modules/ecs/launch_teamplate"
  namespace                     = var.namespace
  ecs_cluster_name              = module.aws_ecs_cluster.ecs_cluster_name
  security_group_ec2_id         = module.aws_sg.security_group_ec2_id
  ec2_instance_role_profile_arn = module.aws_iam.ec2_instance_role_profile_arn
}

module "aws_ecs_service" {
  source                   = "./modules/ecs/service"
  namespace                = var.namespace
  service_name             = var.service_name
  ecs_cluster_default_name = module.aws_ecs_cluster.ecs_cluster_name
  ecs_cluster_id           = module.aws_ecs_cluster.ecs_cluster_id
  ecs_service_role_arn     = module.aws_iam.ecs_service_role_arn
  ecs_launch_template_id   = module.aws_launch_template.ecs_launch_template_id
  service_target_group_arn = module.aws_alb.service_target_group_arn
  task_definition_arn      = module.aws_ecs_task_defenition.task_definition_arn
  private_subnet_ids       = module.aws_subnets.private_subnet_ids
}
