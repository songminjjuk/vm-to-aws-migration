# Public 서브넷 1 설정
resource "aws_subnet" "test_public1_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "test_public1_subnet"
  }
}

# Public 서브넷 2 설정
resource "aws_subnet" "test_public2_subnet" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "test_public2_subnet"
  }
}

# Private 서브넷 1 설정
resource "aws_subnet" "test_private1_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "test_private1_subnet"
  }
}

# Private 서브넷 2 설정
resource "aws_subnet" "test_private2_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "test_private2_subnet"
  }
}

# DB 서브넷 1 설정
resource "aws_subnet" "test_db1_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "test_db1_subnet"
  }
}

# DB 서브넷 2 설정
resource "aws_subnet" "test_db2_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "test_db2_subnet"
  }
}
