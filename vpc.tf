module "vpc" {
  source = "./modules/vpc"

  environment = "development"
  region      = "${var.region}"
  vpc_cidr    = "${var.vpc_cidr}"
  name        = "${var.name}"
}
