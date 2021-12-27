resource "aws_lb" "books_api_alb" {
  name               = "books-api-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb_books_api.id]
  idle_timeout       = 400

  subnets = [
    aws_subnet.public_ec2_a.id,
    aws_subnet.public_ec2_b.id
  ]

  tags = {
    Name = "${var.name}-${var.env}"
  }
}

resource "aws_lb_target_group" "tg_books_api" {
  name     = "tg-books-api"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.default_ec2.id

  health_check {
    healthy_threshold = 3
    path = "/api/v1/health"
    port = 9000
    matcher = 200
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.books_api_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_books_api.arn
  }
}

resource "aws_lb_target_group_attachment" "tg_books_api" {
  target_group_arn = aws_lb_target_group.tg_books_api.arn
  target_id        = aws_instance.books_api.id
  port             = 9000
}
