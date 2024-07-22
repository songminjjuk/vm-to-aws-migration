# ALB for Web Servers
resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.test_web_sg.id]
  subnets            = [
    aws_subnet.test_public1_subnet.id,
    aws_subnet.test_public2_subnet.id
  ]

  tags = {
    Name = "web_alb"
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "web_tg"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

# ALB for WAS Servers (Internal)
resource "aws_lb" "was_alb" {
  name               = "was-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.test_was_sg.id]
  subnets            = [
    aws_subnet.test_private1_subnet.id,
    aws_subnet.test_private2_subnet.id
  ]

  tags = {
    Name = "was_alb"
  }
}

resource "aws_lb_target_group" "was_tg" {
  name     = "was-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.test_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "was_tg"
  }
}

resource "aws_lb_listener" "was_listener" {
  load_balancer_arn = aws_lb.was_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.was_tg.arn
  }
}
