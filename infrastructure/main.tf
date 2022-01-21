terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
//  backend "remote" {
//    organization = "r4cc00n"
//
//    workspaces {
//      name = "aws-templates"
//    }
//  }
}

provider "aws" {

  region = "us-west-1"

  default_tags {
    tags = {
      Environment = "Test"
      Owner       = "TFProviders"
      Project     = "Test"
      Name        = "Terraform-Resource"
    }
  }
}

module "notebook" {
  source = "./modules/sagemaker"
}
