# DB Subnet Group
resource "aws_db_subnet_group" "test_db_subnet_group" {
  name       = "test_db_subnet_group"
  subnet_ids = [
    aws_subnet.test_db1_subnet.id,
    aws_subnet.test_db2_subnet.id
  ]

  tags = {
    Name = "test_db_subnet_group"
  }
}

# DB 서버 (RDS 인스턴스)
resource "aws_db_instance" "db_server" {
  identifier             = "temp"
  allocated_storage      = 20
  engine                 = "mariadb"
  engine_version         = "10.11.6"
  instance_class         = "db.t3.micro"
  db_name                = "temp"
  username               = "tempuser"
  password               = "test1234"
  parameter_group_name   = "default.mariadb10.11"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.test_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.test_db_subnet_group.name

  tags = {
    Name = "db_server"
  }
}
