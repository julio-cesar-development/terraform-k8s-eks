resource "aws_eks_cluster" "eks-cluster" {
  name    = var.cluster_name
  version = var.cluster_version

  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.cluster-master-sg.id]
    subnet_ids         = var.cluster_private_subnets.*.id
  }

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-attachment-cluster-policy,
    aws_iam_role_policy_attachment.eks-cluster-attachment-service-policy,
  ]
}

data "aws_eks_cluster_auth" "cluster-auth" {
  name = aws_eks_cluster.eks-cluster.name
}
