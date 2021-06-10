variable "aws_region" {
  description = "The AWS region to build network infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "vpcname" {
  type        = string
  default     = "MyVPCk8s"
}


variable "cluster_version" {
  type        = string
  default     = "1.20"
}

variable "cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["172.16.1.0/24","172.16.2.0/24","172.16.3.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  default     = ["172.16.4.0/24","172.16.5.0/24","172.16.6.0/24"]
}

variable "instance_type1" {
  type        = string
  default     = "m5.large"
}

variable "instance_type2" {
  type        = string
  default     = "t2.small"
}