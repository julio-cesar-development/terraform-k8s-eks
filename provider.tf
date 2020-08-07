provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

provider "kubernetes" {
  load_config_file       = false
  host                   = module.master.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(module.master.eks_cluster.certificate_authority.0.data)
  token                  = module.master.eks_cluster_auth.token
}
