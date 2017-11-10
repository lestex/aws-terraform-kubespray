resource "aws_instance" "instance1" {
  #count = "${length(var.public_subnets)}"
  ami           = "ami-1e339e71"
  instance_type = "t2.nano"

  vpc_security_group_ids = ["${module.vpc.default_sg}","${module.vpc.allow_ssh-sg}"]
  subnet_id         = "${module.vpc.public_subnets[1]}"
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

# output "module.vpc.default_sg"{
#   value = "${module.vpc.default_sg}"
# }

# output "module.vpc.public_subnets"{
#   value = "${module.vpc.public_subnets[1]}"
# }

output "instance1"{
  value = "${module.vpc.public_subnets[1]}"
}

