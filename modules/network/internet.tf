resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = format("%s-main-gw", var.cluster_name)
  }

  depends_on = [aws_vpc.main-vpc]
}
