  output "aws_lb" {
    value = aws_lb.books_api_alb.dns_name
}
