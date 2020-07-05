# AWS variables
variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  default     = "invalid"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  default     = "invalid"
}

variable "aws_az_count" {
  type        = number
  description = "AWS availability zones count"
  default     = 2
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "sa-east-1"
}

variable "aws_public_cidr" {
  type        = string
  description = "AWS public subnet CIDR block"
  default     = "10.0.0.0/16"
}

variable "aws_private_cidr" {
  type        = string
  description = "AWS private subnet CIDR block"
  default     = "10.0.32.0/20"
}

variable "aws_instance_size" {
  type        = string
  description = "AWS instance size for K8S nodes"
  # t2.medium: 2 vCPU and 4 GiB memory
  default = "t2.medium"
}

variable "aws_auto_scale_options" {
  type        = map
  description = "AWS auto scale options for K8S nodes"
  default = {
    desired_size = 3
    max_size     = 10
    min_size     = 3
  }
}

variable "aws_key_name" {
  type        = string
  description = "AWS SSH key name for K8S nodes"
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

# Miscellaneous
variable "generate_kubeconfig" {
  type        = bool
  description = "Decide whether generate a kubeconfig file locally or not"
  default     = true
}
