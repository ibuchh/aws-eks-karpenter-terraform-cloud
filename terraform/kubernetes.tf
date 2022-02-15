#############################################################
###                      Kubernetes                       ###
#############################################################

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

# resource "null_resource" "eks_context_switcher" {

#   # triggers = {
#   #   always_run = timestamp()
#   # }

#   provisioner "local-exec" {
#     command = "sudo aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
#   }
#   depends_on       = [module.eks.kubeconfig]
# }
# provider "helm" {
#   kubernetes {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1alpha1"
#       args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
#       command     = "aws"
#     }
#   }
# }

# data "external" "kube-config" { 
#   program = [
#     "/usr/bin/env", "bash", "-c", 
#     "echo -n '{'\\\"config\\\": \\\"$${KUBECONFIG-$HOME/.kube/config}\\\"'}'"]
# }
# locals {
#   kubeconfig_path = length(var.kubeconfig_path) == 0 ? data.external.kube-config.config : var.kubeconfig_path
# }