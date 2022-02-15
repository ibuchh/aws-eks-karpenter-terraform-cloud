#! /bin/sh
source env.sh
kubectl delete deployment inflate
kubectl delete node -l karpenter.sh/provisioner-name=default
helm uninstall karpenter --namespace karpenter
terraform state rm module.eks.kubernetes_config_map.aws_auth
terraform destroy -auto-approve