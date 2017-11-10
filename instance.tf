resource "aws_instance" "instance" {
  count = "${length(var.public_subnets)}"
  ami           = "ami-1e339e71"
  instance_type = "t2.nano"

  vpc_security_group_ids = ["${module.vpc.default_sg}","${module.vpc.allow_ssh-sg}"]
  subnet_id         = "${module.vpc.public_subnets[count.index]}"
  key_name = "mykeypair"
  
  tags {
    Name              = "development"
    builtWith         = "terraform"
    KubernetesCluster = "${var.name}"
  }

  depends_on = ["module.vpc"]
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

output "instances"{
  value = "${aws_instance.instance.*.public_ip}"
}

