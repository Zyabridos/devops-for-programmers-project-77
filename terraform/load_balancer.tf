resource "aws_lb" "app_lb" {
  name               = "app-lb"
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
  security_groups    = [aws_security_group.web_sg.id]
}

resource "aws_lb_target_group" "tg" {
  name     = "app-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  lifecycle {
    create_before_destroy = true
  }

  health_check {
    path                = "/"
    port                = "3000"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  count            = 2
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 3000
}
