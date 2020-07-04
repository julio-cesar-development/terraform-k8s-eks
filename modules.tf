module "network" {
  source = "./modules/network"

  aws_az_count     = var.aws_az_count
  aws_region       = var.aws_region
  aws_public_cidr  = var.aws_public_cidr
  aws_private_cidr = var.aws_private_cidr

  cluster_name = var.cluster_name
}
