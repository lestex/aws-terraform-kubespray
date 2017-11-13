#########################
# terraform variables
#########################
variable "region" {
  default = "eu-central-1"
}

variable "profile" {
  default = "terraform"
}

variable PATH_TO_PUBLIC_KEY {
  default = "~/.ssh/id_rsa.pub"
}
