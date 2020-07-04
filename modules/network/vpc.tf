resource "aws_vpc" "main-vpc" {
  cidr_block           = var.aws_public_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = format("%s-main-vpc", var.cluster_name)
  }
}
