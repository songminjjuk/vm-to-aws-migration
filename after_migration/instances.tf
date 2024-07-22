# web_instance 가져오기
data "aws_instance" "web" {
  filter {
    name = "tag:Name"
    values = ["web"]
  }
}

# AMI 생성
resource "aws_ami_from_instance" "create_web_ami" {
  name               = "WebServerAMI"
  source_instance_id = data.aws_instance.web.id

  tags = {
    Name = "WebServerAMI"
  }
}

# was_instance 가져오기
data "aws_instance" "was" {
  filter {
    name = "tag:Name"
    values = ["was"]
  }
}

# AMI 생성
resource "aws_ami_from_instance" "create_was_ami" {
  name               = "WasServerAMI"
  source_instance_id = data.aws_instance.was.id

  tags = {
    Name = "WasServerAMI"
  }
}
