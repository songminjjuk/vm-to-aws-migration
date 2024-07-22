resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "test_vpc"
  }
}

# Internet Gateway 설정
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_igw"
  }
}

# Route Table 설정
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "test_public_rt"
  }
}

# Route Table Association for Public Subnets
resource "aws_route_table_association" "rta_public1" {
  subnet_id      = aws_subnet.test_public1_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "rta_public2" {
  subnet_id      = aws_subnet.test_public2_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
