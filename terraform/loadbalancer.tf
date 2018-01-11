###############################
## Kubernetes API Load Balancer
###############################

resource "aws_elb" "kubernetes_api" {
  name                      = "loadbalancer"
  instances                 = ["${aws_instance.controller.*.id}"]
  subnets                   = ["${module.vpc.public_subnets[0]}"]
  cross_zone_load_balancing = false

  security_groups = ["${aws_security_group.kubernetes_api.id}"]

  listener {
    lb_port           = 6443
    instance_port     = 6443
    lb_protocol       = "TCP"
    instance_protocol = "TCP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 15
    target              = "HTTP:8080/healthz"
    interval            = 30
  }

  tags {
    Owner = "kubernetes"
    Name  = "kubernetes-loadbalancer"
  }
}

###############################
## Security group
###############################

resource "aws_security_group" "kubernetes_api" {
  vpc_id = "${module.vpc.vpc_id}"
  name   = "kubernetes-api"

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Owner = "kubernetes"
    Name  = "kubernetes-loadbalancer"
  }
}

###############################
## Outputs
###############################

output "kubernetes_api_dns_name" {
  value = "${aws_elb.kubernetes_api.dns_name}"
}
