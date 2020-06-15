data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "k8s-cluster"
  cluster_version = "1.16"
  subnets         = aws_subnet.subnet-main.*.id
  vpc_id          = aws_vpc.main-vpc.id

  tags = {
    Environment = "staging"
  }

  worker_groups = [
    {
      instance_type = "t2.small"
      asg_max_size  = 3
    }
  ]

  node_groups = {
    nodes = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t2.small"
      k8s_labels = {
        Environment = "staging"
      }
    }
  }

}
