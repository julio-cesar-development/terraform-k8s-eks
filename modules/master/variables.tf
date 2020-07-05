# AWS variables
variable "aws_region" {
  type        = string
  description = "Aws region"
}

# cluster variables
variable "cluster_name" {
  type        = string
  description = "The cluster name"
}

variable "cluster_version" {
  type        = string
  description = "The cluster version"
}

# cluster variables from network module
variable "cluster_vpc" {
  type        = any
  description = "The cluster VPC"
}

variable "cluster_public_subnets" {
  type        = any
  description = "The cluster public subnets"
}

variable "cluster_private_subnets" {
  type        = any
  description = "The cluster private subnets"
}
