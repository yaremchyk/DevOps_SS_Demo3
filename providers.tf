terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
      cloud {
 	organization = "demo3_org"
	workspaces {
  	name = "demo-workspace"

     }
   }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-north-1"
  # access_key = local.creds.ACCESS_KEY_ID
  # secret_key = local.creds.SECRET.ACCESS.KEY

}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = var.secret_name
}

locals {
  creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

