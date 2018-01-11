#################
# etcd instances
#################

resource "aws_instance" "etcd" {
  count         = "${var.etcd-servers-count}"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.etcd_instance_type}"

  subnet_id                   = "${module.vpc.public_subnets[0]}"
  private_ip                  = "${cidrhost("10.0.1.0/24", 150 + count.index)}"
  associate_public_ip_address = true

  vpc_security_group_ids = ["${module.vpc.default_sg}", "${module.vpc.allow_ssh-sg}"]
  key_name               = "mykeypair"

  tags {
    Owner = "kubernetes"
    Name  = "etcd-${count.index}"
    ansibleNodeType = "etcd"
  }

  depends_on = ["module.vpc"]
}
