#########################
# terraform variables
#########################
variable "region" {
  default = "eu-central-1"
}

variable "profile" {
  default = "terraform"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "name" {
  default = "aws-kubernetes"
}

variable PATH_TO_PUBLIC_KEY {
  default = "~/.ssh/id_rsa.pub"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}
