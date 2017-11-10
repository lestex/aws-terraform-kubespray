##############################
# private networking
##############################

# Create nat gateway
resource "aws_nat_gateway" "self" {
  count = "${length(var.private_subnets) - (length(var.private_subnets) -1)}"

  allocation_id = "${aws_eip.self.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[0]}"
}

resource "aws_eip" "self" {
  count = "${length(var.private_subnets) - (length(var.private_subnets) -1)}"
  vpc = true
}


# Create private networks
resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.self.id}"
  cidr_block              = "${var.private_subnets[count.index]}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.environment}-private-${count.index}"
  }

  count = "${length(var.private_subnets)}"
}