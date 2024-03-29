# tfsec:ignore:aws-elb-alb-not-public
resource "aws_lb" "books_api_alb" {
  name                       = "books-api-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg_alb_books_api.id]
  idle_timeout               = 400
  drop_invalid_header_fields = true

  subnets = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1b.id
  ]

  tags = {
    Name = "${var.name}-${var.env}"
  }
}

resource "aws_lb_target_group" "tg_books_api" {
  name     = "tg-books-api"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = aws_vpc.cluster_vpc.id

  health_check {
    healthy_threshold = 3
    path              = "/api/v1/health"
    port              = 9000
    matcher           = 200
  }
}

# tfsec:ignore:aws-elb-http-not-used
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.books_api_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_books_api.arn
  }
}
