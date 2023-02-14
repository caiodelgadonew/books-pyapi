# tfsec:ignore:aws-ec2-no-public-ip-subnet
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.100.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"

  tags = {
    Name = "${local.resource_name}-public-1a"
  }
}

# tfsec:ignore:aws-ec2-no-public-ip-subnet
resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = "10.0.101.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}b"

  tags = {
    Name = "${local.resource_name}-public-1b"
  }
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.igw.id
}


resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.igw.id
}
