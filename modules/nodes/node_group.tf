resource "aws_eks_node_group" "cluster-nodes" {
  cluster_name = var.eks_cluster.name # var.cluster_name

  # node settings
  node_group_name = format("%s-eks-nodes-role", var.cluster_name)
  node_role_arn   = aws_iam_role.eks-nodes-role.arn

  # network settings
  subnet_ids      = var.cluster_private_subnets.*.id
  # to enable SSH access it should have public IPs on public subnet
  # subnet_ids      = var.cluster_public_subnets.*.id

  # instance settings
  instance_types = [var.aws_instance_size]
  scaling_config {
    desired_size = lookup(var.aws_auto_scale_options, "desired_size")
    max_size     = lookup(var.aws_auto_scale_options, "max_size")
    min_size     = lookup(var.aws_auto_scale_options, "min_size")
  }
  # to enable this, the instances should have public IPs on public subnet
  # remote_access {
  #   ec2_ssh_key = var.aws_key_name
  # }

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-nodes-attachment-cni-policy,
    aws_iam_role_policy_attachment.eks-nodes-attachment-worker-node-policy,
    aws_iam_role_policy_attachment.eks-nodes-attachment-container-registry-ro,
  ]
}
