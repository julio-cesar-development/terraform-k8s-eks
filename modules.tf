module "network" {
  source = "./modules/network"
  # AWS variables
  aws_az_count     = var.aws_az_count
  aws_region       = var.aws_region
  aws_public_cidr  = var.aws_public_cidr
  aws_private_cidr = var.aws_private_cidr
  # cluster variables
  cluster_name = var.cluster_name
}

module "master" {
  source = "./modules/master"
  # AWS variables
  aws_region = var.aws_region
  # cluster variables
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  # cluster variables from network module
  cluster_vpc             = module.network.cluster_vpc
  cluster_public_subnets  = module.network.public_subnets
  cluster_private_subnets = module.network.private_subnets
}

module "nodes" {
  source = "./modules/nodes"
  # AWS variables
  aws_region             = var.aws_region
  aws_instance_size      = var.aws_instance_size
  aws_auto_scale_options = var.aws_auto_scale_options
  aws_key_name           = var.aws_key_name
  # cluster variables
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  # cluster variables from network module
  cluster_vpc             = module.network.cluster_vpc
  cluster_public_subnets  = module.network.public_subnets
  cluster_private_subnets = module.network.private_subnets
  # cluster variables from master module
  eks_cluster           = module.master.eks_cluster
  eks_cluster_master_sg = module.master.eks_cluster_master_sg
}
