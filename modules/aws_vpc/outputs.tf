######################################		
# output variables		
######################################		
output "vpc_id" {
  value = "${aws_vpc.self.id}"
}

output "public_subnets" {
  value = "${aws_subnet.public.*.id}"
}

output "default_sg" {
  value = "${aws_vpc.self.default_security_group_id}"
}

output "allow_ssh-sg" {
  value = "${aws_security_group.allow_ssh-sg.id}"
}
