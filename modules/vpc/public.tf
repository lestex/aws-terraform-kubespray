resource "aws_internet_gateway" "self" {
  vpc_id = "${aws_vpc.self.id}"

  tags {
    Name              = "lestex-${var.name}"
    builtWith         = "terraform"
    KubernetesCluster = "${var.name}"
    visibility        = "private,public"
    environment       = "${var.environment}"
  }
}

# Create route tables
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.self.id}"

  tags {
    Name              = "${var.environment}-public-route_table"
    builtWith         = "terraform"
    KubernetesCluster = "${var.name}"
  }
}

resource "aws_route" "public_to_internet" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.self.id}"
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.self.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name              = "${var.environment}-public-${count.index}"
    builtWith         = "terraform"
    KubernetesCluster = "${var.name}"
  }

  count = "${length(var.public_subnets)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

data "aws_availability_zones" "available" {}
