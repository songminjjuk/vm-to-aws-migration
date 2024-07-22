resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  launch_template {
    id      = resource.aws_launch_template.web_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = [
    data.terraform_remote_state.main.outputs.public_subnet1_id,
    data.terraform_remote_state.main.outputs.public_subnet2_id
  ]
  target_group_arns = [data.terraform_remote_state.main.outputs.web_tg_arn]

  tag {
    key                 = "Name"
    value               = "web_server"
    propagate_at_launch = true
  }

  depends_on = [
    resource.aws_ami_from_instance.create_web_ami
  ]
}

resource "aws_autoscaling_group" "was_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  launch_template {
    id      = aws_launch_template.was_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = [
    data.terraform_remote_state.main.outputs.private_subnet1_id,
    data.terraform_remote_state.main.outputs.private_subnet2_id
  ]
  target_group_arns = [data.terraform_remote_state.main.outputs.was_tg_arn]

  tag {
    key                 = "Name"
    value               = "was_server"
    propagate_at_launch = true
  }

  depends_on = [
    resource.aws_ami_from_instance.create_was_ami
  ]
}
