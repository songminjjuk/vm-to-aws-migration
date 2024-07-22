output "test_vpc_id" {
  value = aws_vpc.test_vpc.id
}

output "web_security_group_id" {
  value = aws_security_group.test_web_sg.id
}

output "was_security_group_id" {
  value = aws_security_group.test_was_sg.id
}

output "db_security_group_id" {
  value = aws_security_group.test_db_sg.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.test_db_subnet_group.name
}

output "db_subnet_group_id" {
  value = aws_db_subnet_group.test_db_subnet_group.id
}

output "db_subnet_ids" {
  value = aws_db_subnet_group.test_db_subnet_group.subnet_ids
}

output "db_subnet_group_arn" {
  value = aws_db_subnet_group.test_db_subnet_group.arn
}

output "public_subnet1_id" {
  value = aws_subnet.test_public1_subnet.id
}

output "public_subnet2_id" {
  value = aws_subnet.test_public2_subnet.id
}

output "private_subnet1_id" {
  value = aws_subnet.test_private1_subnet.id
}

output "private_subnet2_id" {
  value = aws_subnet.test_private2_subnet.id
}

output "db_subnet1_id" {
  value = aws_subnet.test_db1_subnet.id
}

output "db_subnet2_id" {
  value = aws_subnet.test_db2_subnet.id
}

output "web_tg_arn" {
  value = aws_lb_target_group.web_tg.arn
}

output "was_tg_arn" {
  value = aws_lb_target_group.was_tg.arn
}

output "db_instance_address" {
  value = aws_db_instance.db_server.address
}
