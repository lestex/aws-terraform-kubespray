module "vpc" {
  source = "github.com/lestex/aws-vpc-tf"

  name        = "aws-kubernetes"
  environment = "development"
  region      = "${var.region}"
  vpc_cidr    = "${var.vpc_cidr}"

  public_subnets = ["10.0.1.0/24"]

  map_public_ip_on_launch = true
  enable_nat_gateway      = false
  multi_nat_gateway       = false
}
