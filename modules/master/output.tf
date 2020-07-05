output "eks_cluster" {
  value = aws_eks_cluster.eks-cluster
}

output "eks_cluster_master_sg" {
  value = aws_security_group.cluster-master-sg
}

output "eks_cluster_auth" {
  value = data.aws_eks_cluster_auth.cluster-auth
}
