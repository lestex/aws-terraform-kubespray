variable "region" {
  description = "The AWS region."
}

variable "environment" {
  description = "The name of our environment, i.e. development."
}

variable "enable_dns_hostnames" {
  description = "Should be set to true to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be set true to use private DNS within the VPC"
  default     = true
}

variable "vpc_cidr" {
  description = "The CIDR of the VPC."
}

variable "public_subnets" {
  description = "The list of public subnets to populate."
  default     = []
}

variable "private_subnets" {
  description = "The list of private subnets to populate."
  default     = []
}

variable "name" {
  description = "a name for tagging"
}

output "vpc_id" {
  value = "${aws_vpc.self.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.self.cidr_block}"
}
