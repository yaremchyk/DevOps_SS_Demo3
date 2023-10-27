terraform {
    cloud {
	organization = "demo3_org"
	workspaces {
  	name = "demo-workspace"
	}
    token = "Ym1Wc2zT05t2cg.atlasv1.r5USoZqn351nhBacqD1jrYkSKht887IqbWn0KCZzyKZH6HLXztUH1OxykAmuXuoP3fE"
  }

  
  
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "4.67.0"
#     }
#   }

#   required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-north-1"
}

