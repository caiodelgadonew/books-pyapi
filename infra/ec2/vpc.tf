
resource "aws_vpc" "default_ec2" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "default_ec2"
  }
}

resource "aws_subnet" "private_ec2_a" {
  vpc_id            = aws_vpc.default_ec2.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "private_ec2_a"
    Tier = "private"
  }
}

resource "aws_subnet" "private_ec2_b" {
  vpc_id            = aws_vpc.default_ec2.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "private_ec2_b"
    Tier = "private"
  }
}

resource "aws_subnet" "public_ec2_a" {
  vpc_id                  = aws_vpc.default_ec2.id
  cidr_block              = "10.0.100.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_ec2_a"
    Tier = "public"
  }
}

resource "aws_subnet" "public_ec2_b" {
  vpc_id                  = aws_vpc.default_ec2.id
  cidr_block              = "10.0.101.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_ec2_b"
    Tier = "public"
  }
}

resource "aws_internet_gateway" "default_ec2_igw" {
  vpc_id = aws_vpc.default_ec2.id

  tags = {
    Name = "default_ec2_igw"
  }
}

resource "aws_route_table" "igw_default_ec2" {
  vpc_id = aws_vpc.default_ec2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default_ec2_igw.id
  }

  tags = {
    Name = "default_ec2_igw"
  }
}

resource "aws_main_route_table_association" "default_route_association" {
  vpc_id         = aws_vpc.default_ec2.id
  route_table_id = aws_route_table.igw_default_ec2.id
}


resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_ec2_a.id

  depends_on = [
    aws_internet_gateway.default_ec2_igw
  ]

}

resource "aws_route_table" "natgw_default_ec2" {
  vpc_id = aws_vpc.default_ec2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "natgw_default_ec2"
  }
}

resource "aws_route_table_association" "natgw_route_association" {
  subnet_id      = aws_subnet.private_ec2_a.id
  route_table_id = aws_route_table.natgw_default_ec2.id
  depends_on = [
    aws_instance.books_api
  ]

}
