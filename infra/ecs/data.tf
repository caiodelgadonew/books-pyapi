data "aws_ami" "amazon_linux_ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]

  }

}

data "template_file" "userdata" {
  template = file("scripts/bootstrap.tpl")
  vars = {
    CLUSTER_NAME = aws_ecs_cluster.app.name
  }
}
