# public subnet dynamic
resource "aws_subnet" "main-subnet-public" {
  count = var.aws_az_count
  # the VPC id
  vpc_id = aws_vpc.main-vpc.id
  # cidr blocks 10.0.0.0/24, 10.0.1.0/24, ...
  cidr_block = cidrsubnet(var.aws_public_cidr, 8, count.index)
  # availability_zone    = var.aws_az_names[count.index]
  availability_zone = [for az in ["a", "c"] : format("%s%s", var.aws_region, az)][count.index]

  # apply a public IP to each machine on this subnet
  map_public_ip_on_launch = "true"

  tags = {
    Name                                        = [for az in ["a", "c"] : format("%s-main-subnet-public-1%s", var.cluster_name, az)][count.index]
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  depends_on = [aws_vpc.main-vpc]
}

resource "aws_route_table" "main-public-route-table" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = format("%s-main-public-route-table", var.cluster_name)
  }

  depends_on = [aws_vpc.main-vpc]
}

resource "aws_route" "main-public-route" {
  # The associated route table
  route_table_id = aws_route_table.main-public-route-table.id
  # The CIDR where the traffic comes from
  destination_cidr_block = "0.0.0.0/0"
  # The internet gateway
  gateway_id = aws_internet_gateway.main-gw.id

  depends_on = [aws_internet_gateway.main-gw, aws_route_table.main-public-route-table]
}

resource "aws_route_table_association" "public-route-association" {
  count          = var.aws_az_count
  subnet_id      = element(aws_subnet.main-subnet-public.*.id, count.index)
  route_table_id = aws_route_table.main-public-route-table.id

  depends_on = [aws_route_table.main-public-route-table]
}
