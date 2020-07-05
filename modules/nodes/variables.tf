# AWS variables
variable "aws_region" {
  type        = string
  description = "Aws region"
}

variable "aws_instance_size" {
  type        = string
  description = "AWS instance size for K8S nodes"
}

variable "aws_auto_scale_options" {
  type        = map
  description = "AWS auto scale options for K8S nodes"
}

variable "aws_key_name" {
  type        = string
  description = "AWS SSH key name for K8S nodes"
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

# cluster variables from master module
variable "eks_cluster" {
  type        = any
  description = "The EKS cluster resource"
}

variable "eks_cluster_master_sg" {
  type        = any
  description = "The EKS cluster security groups"
}
