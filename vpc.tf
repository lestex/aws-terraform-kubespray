module "vpc" {
  source = "./modules/aws_vpc"

  environment             = "development"
  region                  = "${var.region}"
  vpc_cidr                = "${var.vpc_cidr}"
  name                    = "${var.name}"
  map_public_ip_on_launch = true
  public_subnets          = "${var.public_subnets}"
  private_network         = false
}
