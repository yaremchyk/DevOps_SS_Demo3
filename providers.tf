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
  
}




