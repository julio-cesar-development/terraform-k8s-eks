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
