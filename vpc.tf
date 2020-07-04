# resource "aws_vpc" "main-vpc" {
#   cidr_block           = "10.0.0.0/16"
#   instance_tenancy     = "default"
#   enable_dns_support   = "true"
#   enable_dns_hostnames = "true"
#   enable_classiclink   = "false"

#   tags = {
#     Name = format("%s-vpc", var.cluster_name)
#   }
# }

# resource "aws_subnet" "main-subnet-public" {
#   count                   = var.aws_az_count
#   cidr_block              = cidrsubnet(aws_vpc.main-vpc.cidr_block, 8, count.index) # 10.0.0.0/24, 10.0.1.0/24, ...
#   map_public_ip_on_launch = "true" # apply a public IP to each machine on this subnet
#   availability_zone       = [for az in ["a", "c"]: format("%s%s", var.aws_region, az)][count.index]
#   # availability_zone       = var.aws_az_names[count.index]
#   vpc_id                  = aws_vpc.main-vpc.id
# }

# resource "aws_internet_gateway" "main-gw" {
#   vpc_id = aws_vpc.main-vpc.id
# }

# resource "aws_route_table" "route-main" {
#   vpc_id = aws_vpc.main-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main-gw.id
#   }

#   tags = {
#     Name = "route-main"
#   }
# }

# resource "aws_route_table_association" "assoc-table-main" {
#   count          = var.aws_az_count
#   subnet_id      = element(aws_subnet.main-subnet-public.*.id, count.index)
#   route_table_id = aws_route_table.route-main.id
# }
