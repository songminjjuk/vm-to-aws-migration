resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-server-"
  image_id      = resource.aws_ami_from_instance.create_web_ami.id
  instance_type = "t2.micro"
  key_name      = "aws5"

  network_interfaces {
    associate_public_ip_address = true
    device_index                = 0
    security_groups             = [data.terraform_remote_state.main.outputs.web_security_group_id]
  }
}

resource "aws_launch_template" "was_launch_template" {
  name_prefix   = "was-server-"
  image_id      = resource.aws_ami_from_instance.create_was_ami.id
  instance_type = "t2.micro"
  key_name      = "aws5"

  network_interfaces {
    associate_public_ip_address = false
    device_index                = 0
    security_groups             = [data.terraform_remote_state.main.outputs.was_security_group_id]
  }
}
