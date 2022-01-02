resource "aws_launch_configuration" "app" {
  name                 = local.service_name
  image_id             = data.aws_ami.amazon_linux_ecs.id
  instance_type        = var.instance_type
  user_data            = data.template_file.userdata.rendered
  iam_instance_profile = aws_iam_instance_profile.ecs.name
  security_groups      = [aws_security_group.sg_ec2_books_api.id]

  depends_on = [
    aws_nat_gateway.nat,
    aws_rds_cluster_instance.app
  ]
}

resource "aws_autoscaling_group" "app" {
  name                 = local.service_name
  launch_configuration = aws_launch_configuration.app.name
  min_size             = 2
  max_size             = 6
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity  = "1Minute"
  vpc_zone_identifier  = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]
  health_check_type    = "ELB"
  target_group_arns    = [aws_lb_target_group.tg_books_api.arn]


  tag {
    key                 = "Name"
    value               = "${local.service_name}-node"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "autoscalingpolicy" {
  name                   = "terraform-autoscalepolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
}

resource "aws_autoscaling_policy" "autoscalepolicy-down" {
  name                   = "terraform-autoscalepolicy-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
}
