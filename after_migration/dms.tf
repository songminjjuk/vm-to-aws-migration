# DMS 보안 그룹 설정
resource "aws_security_group" "dms_sg" {
  name   = "dms_sg"
  vpc_id = data.terraform_remote_state.main.outputs.test_vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # VPC 내 통신 허용
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dms_sg"
  }
}

# DMS 복제 subnet group
resource "aws_dms_replication_subnet_group" "dms_subnet_group" {
  replication_subnet_group_id          = "dms-subnet-group"
  replication_subnet_group_description = "DMS Subnet Group"
  subnet_ids                           = [
    data.terraform_remote_state.main.outputs.db_subnet1_id,
    data.terraform_remote_state.main.outputs.db_subnet2_id
  ]
  tags = {
    Name = "dms-subnet-group"
  }
}

resource "aws_dms_replication_instance" "replication_instance" {
  replication_instance_id     = "dms-replication-instance"
  replication_instance_class  = "dms.t3.micro"
  allocated_storage           = 20
  vpc_security_group_ids      = [aws_security_group.dms_sg.id]
  replication_subnet_group_id = aws_dms_replication_subnet_group.dms_subnet_group.replication_subnet_group_id
  multi_az                    = false
  availability_zone           = "ap-northeast-2a"
  apply_immediately           = true
  engine_version              = "3.4.6"
  publicly_accessible         = false
}

# 소스 DB 엔드포인트 설정
resource "aws_dms_endpoint" "source_endpoint" {
  endpoint_id   = "source-endpoint"
  endpoint_type = "source"
  engine_name   = "mariadb"
  username      = "tempuser"
  password      = "test1234"
  server_name   = "10.0.1.34"
  port          = 3306
  database_name = "temp"
}

# 타겟 RDS 엔드포인트 설정
resource "aws_dms_endpoint" "target_endpoint" {
  endpoint_id   = "target-endpoint"
  endpoint_type = "target"
  engine_name   = "mariadb"
  username      = "tempuser"
  password      = "test1234"
  server_name   = data.terraform_remote_state.main.outputs.db_instance_address
  port          = 3306
  database_name = "temp"
}

# DMS 복제 작업 설정 및 실행
resource "aws_dms_replication_task" "replication_task" {
  replication_task_id         = "dms-task"
  migration_type              = "full-load"
  source_endpoint_arn         = aws_dms_endpoint.source_endpoint.endpoint_arn
  target_endpoint_arn         = aws_dms_endpoint.target_endpoint.endpoint_arn
  replication_instance_arn    = aws_dms_replication_instance.replication_instance.replication_instance_arn

  table_mappings = <<EOF
{
  "rules": [
    {
      "rule-type": "selection",
      "rule-id": "1",
      "rule-name": "1",
      "object-locator": {
        "schema-name": "%",
        "table-name": "%"
      },
      "rule-action": "include"
    }
  ]
}
EOF

  tags = {
    Name = "dms-task"
  }
}
