resource "aws_instance" "books_api" {
  ami                    = data.aws_ami.amazon_linux_latest.id
  instance_type          = var.instance_type
  user_data              = file("scripts/bootstrap.sh")
  subnet_id              = aws_subnet.private_ec2_a.id
  iam_instance_profile   = aws_iam_instance_profile.ssm_iam_profile.name
  vpc_security_group_ids = [aws_security_group.sg_ec2_books_api.id]

  depends_on = [
    aws_nat_gateway.nat
  ]

  tags = {
    Name = "${var.name}-${var.env}"
  }
}
