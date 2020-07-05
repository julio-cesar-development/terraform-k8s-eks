# AWS variables
variable "aws_az_count" {
  type        = number
  description = "AWS availability zones count"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_public_cidr" {
  type        = string
  description = "AWS public subnet CIDR block"
}

variable "aws_private_cidr" {
  type        = string
  description = "AWS private subnet CIDR block"
}

# cluster variables
variable "cluster_name" {
  type        = string
  description = "The cluster name"
}
