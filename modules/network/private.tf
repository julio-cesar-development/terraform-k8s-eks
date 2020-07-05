# private subnet dynamic
resource "aws_subnet" "main-subnet-private" {
  count = var.aws_az_count
  # the VPC id
  vpc_id = aws_vpc.main-vpc.id
  # cidr blocks 10.0.32.0/24, 10.0.33.0/24, ...
  cidr_block = cidrsubnet(var.aws_private_cidr, 4, count.index)
  # availability_zone    = var.aws_az_names[count.index]
  availability_zone = [for az in ["a", "c"] : format("%s%s", var.aws_region, az)][count.index]

  tags = {
    Name                                        = [for az in ["a", "c"] : format("%s-main-subnet-private-1%s", var.cluster_name, az)][count.index]
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [aws_vpc.main-vpc]
}

resource "aws_route_table" "main-private-route-table" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = format("%s-main-private-route-table", var.cluster_name)
  }

  depends_on = [aws_vpc.main-vpc]
}

resource "aws_route" "main-private-route" {
  # The associated route table
  route_table_id = aws_route_table.main-private-route-table.id
  # The CIDR where the traffic comes from
  destination_cidr_block = "0.0.0.0/0"
  # The NAT gateway
  nat_gateway_id = aws_nat_gateway.main-nat-gw.id

  depends_on = [aws_nat_gateway.main-nat-gw, aws_route_table.main-private-route-table]
}

resource "aws_route_table_association" "private-route-association" {
  count          = var.aws_az_count
  subnet_id      = element(aws_subnet.main-subnet-private.*.id, count.index)
  route_table_id = aws_route_table.main-private-route-table.id

  depends_on = [aws_route_table.main-private-route-table]
}
