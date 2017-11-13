resource "aws_instance" "instance-public" {
  ami           = "ami-1e339e71"
  instance_type = "t2.nano"

  vpc_security_group_ids = ["${module.vpc.default_sg}", "${module.vpc.allow_ssh-sg}"]
  subnet_id              = "${module.vpc.public_subnets[0]}"
  key_name               = "mykeypair"

  tags {
    Name              = "development"
    builtWith         = "terraform"
    KubernetesCluster = "k8s"
  }

  depends_on = ["module.vpc"]
}

resource "aws_instance" "instance-private" {
  ami           = "ami-1e339e71"
  instance_type = "t2.nano"

  vpc_security_group_ids = ["${module.vpc.allow_ssh-sg}"]
  subnet_id              = "${module.vpc.private_subnets[0]}"
  key_name               = "mykeypair"

  tags {
    Name              = "development"
    builtWith         = "terraform"
    KubernetesCluster = "k8s"
  }

  depends_on = ["module.vpc"]
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

output "instances" {
  value = "${aws_instance.instance-public.public_ip}"
}
