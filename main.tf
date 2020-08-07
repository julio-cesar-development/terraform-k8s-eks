terraform {
  required_version = "~> 0.12.0"

  required_providers {
    aws        = "~> 3.0"
    kubernetes = "~> 1.9"
  }

  backend "s3" {
    bucket = "blackdevs-aws"
    key    = "terraform/k8s-eks/state.tfstate"
    region = "sa-east-1"
  }
}
