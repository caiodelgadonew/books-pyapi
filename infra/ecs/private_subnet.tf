resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"

  tags = {
    Name = "${local.resource_name}-private-1a"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"

  tags = {
    Name = "${local.resource_name}-private-1b"
  }
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "private_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.nat.id
}

