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