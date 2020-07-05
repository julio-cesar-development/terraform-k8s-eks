output "kube_config_cluster_ca_certificate" {
  value = module.master.eks_cluster.certificate_authority.0.data
}

output "endpoint" {
  value = module.master.eks_cluster.endpoint
}

output "kube_config_token" {
  value = module.master.eks_cluster_auth.token
}

output "kube_config_raw_config" {
  value = local.kubeconfig
}
