terraform {
    cloud {
	organization = "demo3_org"
	workspaces {
  	name = "demo-workspace"
	}
  }

  
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }

  required_version = ">= 1.2.0"
}

