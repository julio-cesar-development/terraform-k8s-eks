output "main-vpc" {
  value = aws_vpc.main-vpc
}

output "subnets-public" {
  value = aws_subnet.main-subnet-public.*.id
}

output "subnets-private" {
  value = aws_subnet.main-subnet-private.*.id
}
