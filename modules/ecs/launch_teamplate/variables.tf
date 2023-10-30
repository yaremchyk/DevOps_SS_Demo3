variable "namespace" {
  description = "Namespace for resource names"
  type        = string
}

variable "environment" {
  description = "Environment for deployment"
  default     = "staging"
  type        = string
}

variable "ec2_instance_role_profile_arn" {
  type = string
  default = "arn:aws:iam::025389115636:role/dev-ec2-instance-role-profile-staging"
}

#variable "key_pair_name" {
#  default = "app-key-pair"
#}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_group_ec2_id" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}