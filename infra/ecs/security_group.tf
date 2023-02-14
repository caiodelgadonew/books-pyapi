resource "aws_security_group" "sg_ec2_books_api" {
  name        = "${var.name}-${var.env}-app"
  vpc_id      = aws_vpc.cluster_vpc.id
  description = "Security Group for books-api Web Servers"

}

# tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group_rule" "ingress_tcp_traffic" {
  count = length(var.tcp_ports)

  description = "Allow ingress all traffic"
  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = var.allowed_cidr_blocks
  from_port   = element(var.app_ports, count.index)
  to_port     = element(var.app_ports, count.index)

  security_group_id = aws_security_group.sg_ec2_books_api.id
}

# tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "egress_all_traffic" {
  security_group_id = aws_security_group.sg_ec2_books_api.id
  description       = "Allow egress all traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "sg_alb_books_api" {
  name        = "${var.name}-${var.env}-alb"
  vpc_id      = aws_vpc.cluster_vpc.id
  description = "Security Group for books-api Load Balancers"

}

# tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group_rule" "alb_ingress_tcp_traffic" {
  count = length(var.tcp_ports)

  description = "Allow ingress TCP traffic"
  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = var.allowed_cidr_blocks
  from_port   = element(var.tcp_ports, count.index)
  to_port     = element(var.tcp_ports, count.index)

  security_group_id = aws_security_group.sg_alb_books_api.id
}

# tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "lb_egress_all_traffic" {
  security_group_id = aws_security_group.sg_alb_books_api.id
  description       = "Allow egress all traffic"

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}



resource "aws_security_group" "sg_rds" {
  name        = "${var.name}-${var.env}-rds"
  vpc_id      = aws_vpc.cluster_vpc.id
  description = "Security Group for books-api Databases"

}

# tfsec:ignore:aws-ec2-no-public-ingress-sgr
resource "aws_security_group_rule" "db_ingress_tcp_traffic" {
  count = length(var.tcp_ports)

  description = "Allow ingress all traffic"
  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = var.allowed_cidr_blocks
  from_port   = 3306
  to_port     = 3306

  security_group_id = aws_security_group.sg_rds.id
}

# tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group_rule" "db_egress_all_traffic" {
  description       = "Allow egress all traffic"
  security_group_id = aws_security_group.sg_rds.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
