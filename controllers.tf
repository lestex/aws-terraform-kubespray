######################
# K8s controllers
######################

resource "aws_instance" "controller" {
  count         = "${var.k8s-controllers-count}"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.controller_instance_type}"

  subnet_id                   = "${module.vpc.public_subnets[0]}"
  private_ip                  = "${cidrhost("10.0.1.0/24", 50 + count.index)}"
  associate_public_ip_address = true

  vpc_security_group_ids = ["${module.vpc.default_sg}", "${module.vpc.allow_ssh-sg}"]
  key_name               = "mykeypair"

  tags {
    Owner = "kubernetes"
    Name  = "controller-${count.index}"
    ansibleNodeType = "controller"
  }

  depends_on = ["module.vpc"]
}
