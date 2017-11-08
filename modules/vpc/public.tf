resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.self.id}"

  tags {
    builtWith         = "terraform"
    KubernetesCluster = "${var.name}"
    Name              = "lestex-${var.name}"
    visibility        = "private,public"
    environment       = "${var.environment}"
  }
}
