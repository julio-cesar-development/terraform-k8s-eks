resource "aws_nat_gateway" "main-nat-gw" {
  allocation_id = aws_eip.main-eip.id
  # use the first public subnet
  subnet_id = aws_subnet.main-subnet-public.0.id

  tags = {
    Name = format("%s-main-nat-gw", var.cluster_name)
  }

  depends_on = [aws_eip.main-eip]
}
