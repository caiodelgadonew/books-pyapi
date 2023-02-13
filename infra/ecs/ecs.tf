
resource "aws_cloudwatch_log_group" "app" {
  name = local.service_name

  tags = {
    name = local.service_name
  }
}

resource "aws_ecs_cluster" "app" {
  name = local.service_name

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.app.name
      }
    }
  }

  tags = {
    name = local.service_name
  }
}


resource "aws_ecs_task_definition" "app" {
  family = local.service_name

  container_definitions = jsonencode(local.container_definitions)

}

resource "aws_ecs_service" "app" {
  name            = local.service_name
  cluster         = aws_ecs_cluster.app.id
  task_definition = aws_ecs_task_definition.app.id

  desired_count = 2

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  lifecycle {
    ignore_changes = [task_definition]
  }
}
