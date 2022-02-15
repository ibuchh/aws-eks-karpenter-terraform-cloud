terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  required_version = ">= 0.14"
}

provider "aws" {
  region = var.region
  profile = "ibuchh-poc"
}


####################################################################
### pre-reqs
### terraform login
### export TERRAFORM_CONFIG=$HOME/.terraform.d/credentials.tfrc.json"
#####################################################################


# terraform {
#   cloud {
#     organization = "aws-terraform"

#     workspaces {
#       name = "aws-eks-karpenter-terraform-cloud"
#     }
#   }
# }