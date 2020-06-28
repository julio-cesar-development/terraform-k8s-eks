# AWS variables
variable "aws_az_count" {
  type        = number
  description = "Count of zones to be available"
  default     = 2
}

variable "aws_az_names" {
  type        = list(string)
  description = "Name of zones to be available"
  default     = ["sa-east-1a", "sa-east-1c"]
}

variable "aws_instance_size" {
  type        = string
  description = "Size of the K8S instances at AWS"
  # t2.medium: 2 vCPU and 4 GiB memory
  default     = "t2.medium"
}

variable "aws_key_name" {
  type        = string
  description = "SSH public key"
  default     = "key_aws"
}
