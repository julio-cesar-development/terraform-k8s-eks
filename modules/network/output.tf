output "cluster_vpc" {
  value = aws_vpc.main-vpc
}

output "public_subnets" {
  value = aws_subnet.main-subnet-public
}

output "private_subnets" {
  value = aws_subnet.main-subnet-private
}
