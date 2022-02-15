#############################################################
###                       Amazon EKS                      ###
#############################################################

module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "17.24.0"
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  vpc_id                          = module.vpc.vpc_id
  subnets                         = module.vpc.private_subnets
  enable_irsa                     = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # create_eks             = true
  # manage_aws_auth        = true
  write_kubeconfig = true
  # kubeconfig_output_path = "${var.home_dir}/.kube/config/${var.cluster_name}"
  kubeconfig_output_path = "${var.home_dir}/.kube/config"
  # kubeconfig_output_path = "./"
  kubeconfig_name        = var.cluster_name

  # Only need one node to get Karpenter up and running

  worker_groups = [
    {
      name          = "karpenter-group-1"
      instance_type = "t3a.medium"
      asg_max_size  = 1
    }
  ]

  tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
