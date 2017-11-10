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

resource "aws_route_table" "private" {
  count  = "${length(var.private_subnets)}"
  vpc_id = "${aws_vpc.environment.id}"

  tags {
    Name = "${var.environment}-private"
  }
}

resource "aws_route" "private_nat_gateway" {
  count                  = "${length(var.private_subnets)}"
  route_table_id         = "${aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.environment.*.id[count.index]}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
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