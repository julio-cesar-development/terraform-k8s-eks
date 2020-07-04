# AWS variables
variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
}

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

variable "aws_instance_size" {
  type        = string
  description = "Size of the K8S instances at AWS"
  # t2.medium: 2 vCPU and 4 GiB memory
  default = "t2.medium"
}

variable "aws_key_name" {
  type        = string
  description = "SSH public key"
  default     = "key_aws"
}

# Cluster variables
variable "cluster_name" {
  type        = string
  description = "The cluster name"
  default     = "k8s-cluster"
}

variable "cluster_version" {
  type        = string
  description = "The cluster version"
  default     = "1.16"
}
