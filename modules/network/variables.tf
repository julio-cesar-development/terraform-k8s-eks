# AWS variables
variable "aws_az_count" {
  type        = number
  description = "Count of zones to be available"
  default     = 2
}

variable "aws_region" {
  type        = string
  description = "Aws region"
  default     = "sa-east-1"
}

variable "aws_public_cidr" {
  type        = string
  description = "Aws public subnet CIDR block"
  default     = "10.0.0.0/16"
}

variable "aws_private_cidr" {
  type        = string
  description = "Aws private subnet CIDR block"
  default     = "10.0.32.0/20"
}

variable "cluster_name" {
  type        = string
  description = "The cluster name"
  default     = "k8s-cluster"
}
