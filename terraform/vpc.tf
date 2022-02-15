#############################################################
###                           VPC                         ###
#############################################################

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                   = var.vpc_name
  cidr                   = var.vpc_cidr_block
  azs                    = data.aws_availability_zones.available.names
  private_subnets        = slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count)
  public_subnets         = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "karpenter.sh/discovery"                    = "${var.cluster_name}"
  }
}

