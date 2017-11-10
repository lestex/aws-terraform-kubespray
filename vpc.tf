module "vpc" {
  source = "./modules/vpc"

  environment             = "development"
  region                  = "${var.region}"
  vpc_cidr                = "${var.vpc_cidr}"
  name                    = "${var.name}"
  map_public_ip_on_launch = true
  public_subnets          = "${var.public_subnets}"
  private_network         = false
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
