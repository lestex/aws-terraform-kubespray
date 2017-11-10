##############################
# input and output variables
##############################

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

variable "map_public_ip_on_launch" {
  description = "Map public IP on launch for public subnet"
  default     = true
}

variable "private_network" {
  description = "Create private network (bool)"
}

######################################
# data providers
######################################
data "aws_availability_zones" "available" {}

######################################
# output variables
######################################
output "vpc_id" {
  value = "${aws_vpc.self.id}"
}

output "public_subnets" {  
  value = "${aws_subnet.public.*.id}"
}

output "default_sg" {
  value = "${aws_vpc.self.default_security_group_id}"
}

output "allow_ssh-sg" {
  value = "${aws_security_group.allow_ssh-sg.id}"
}