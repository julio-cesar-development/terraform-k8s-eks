# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_id
# }

# module "eks" {
#   source          = "terraform-aws-modules/eks/aws"
#   cluster_name    = var.cluster_name
#   cluster_version = var.cluster_version
#   subnets         = aws_subnet.main-subnet-public.*.id
#   vpc_id          = aws_vpc.main-vpc.id

#   tags = {
#     environment = "staging"
#   }

#   worker_groups = [
#     {
#       instance_type = var.aws_instance_size
#       asg_max_size  = 3
#     }
#   ]

#   node_groups = {
#     nodes = {
#       name             = format("%s-node", var.cluster_name)
#       desired_capacity = 2
#       max_capacity     = 3
#       min_capacity     = 1
#       instance_type    = var.aws_instance_size
#       key_name         = var.aws_key_name
#       k8s_labels = {
#         environment = "staging"
#       }
#     }
#   }
# }
