##############
# variables
##############
variable "region" {
  default = "eu-central-1"
}

variable "profile" {
  default = "terraform"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "~/.ssh/id_rsa.pub"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "amis" {
  type = "map"

  default = {
    eu-central-1 = "ami-1e339e71"
  }
}

variable "k8s-nodes-count" {
  description = "number of worker nodes in the cluster"
  default     = 0
}

variable "k8s-controllers-count" {
  description = "number of control plane servers in the cluster"
  default     = 2
}

variable "node_instance_type" {
  description = "node instance type"
  default     = "t2.nano"
}

variable "controller_instance_type" {
  description = "node instance type"
  default     = "t2.nano"
}

variable "etcd_instance_type" {
  description = "etcd instance type"
  default     = "t2.nano"
}

variable "keypair_name" {
  default = "mykeypair"
}
