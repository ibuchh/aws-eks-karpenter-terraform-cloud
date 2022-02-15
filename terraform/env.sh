
#! /bin/sh
export cluster_name="eks-karpenter"
export profile="ibuchh-poc"
export AWS_DEFAULT_PROFILE=${profile}
export home_dir=${HOME}
export TF_VAR_cluster_name=${cluster_name}
export TF_VAR_profile=${profile}
export TF_VAR_home_dir=${home_dir}
mkdir ${HOME}/.kube
touch ${HOME}/.kube/config
export KUBECONFIG=${HOME}/.kube/config
export KUBE_CONFIG_PATH=${HOME}/.kube/config


