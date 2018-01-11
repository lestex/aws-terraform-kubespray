#############
# K8s nodes
#############

resource "aws_instance" "node" {
  count         = "${var.k8s-nodes-count}"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.node_instance_type}"

  subnet_id  = "${module.vpc.public_subnets[0]}"
  private_ip = "${cidrhost("10.0.1.0/24", 100 + count.index)}"

  vpc_security_group_ids = ["${module.vpc.default_sg}", "${module.vpc.allow_ssh-sg}"]
  key_name               = "mykeypair"

  tags {
    Owner = "kubernetes"
    Name  = "node-${count.index}"
    ansibleNodeType = "worker"
  }

  depends_on = ["module.vpc"]
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
