##############################
# private networking
##############################

# Create nat gateway
resource "aws_nat_gateway" "self" {
  # create more than 1 gateway if multi_nat_gateway is set to true
  count = "${var.multi_nat_gateway == 0 ? 1 : length(var.public_subnets)}"

  allocation_id = "${aws_eip.self.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
}

# Create elastic IP for nat gateway
resource "aws_eip" "self" {
  count = "${var.multi_nat_gateway == 0 ? 1 : length(var.public_subnets)}"
  vpc   = true
}

# Create route table for private network
resource "aws_route_table" "private" {
  count  = "${var.multi_nat_gateway == 0 ? 1 : length(var.public_subnets)}"
  vpc_id = "${aws_vpc.self.id}"

  tags {
    Name              = "${var.environment}-private-route_table"
    builtWith         = "terraform"
    KubernetesCluster = "${var.name}"
  }
}

# Create route for private network
resource "aws_route" "through_nat_gateway" {
  count                  = "${var.multi_nat_gateway == 0 ? 1 : length(var.public_subnets)}"
  route_table_id         = "${var.multi_nat_gateway == 0 ? aws_route_table.private.id : aws_route_table.private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${var.multi_nat_gateway == 0 ? aws_nat_gateway.self.id : aws_nat_gateway.self.*.id[count.index]}"
}

# # create association with route
# resource "aws_route_table_association" "private" {
#   count          = "${length(var.private_subnets)}"
#   subnet_id      = "${var.multi_nat_gateway == 0 ? aws_subnet.private.id : aws_subnet.private.*.id[count.index]}"
#   route_table_id = "${var.multi_nat_gateway == 0 ? aws_route_table.private.id : aws_route_table.private.*.id[count.index]}"
# }

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
