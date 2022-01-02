locals {
  service_name = var.name
  env          = var.env

  container_image = var.container_image


  resource_name = "${local.service_name}-${local.env}"

  container_definitions = [{
    name      = local.service_name
    image     = local.container_image
    command   = []
    essential = true
    cpu       = 128
    memory    = 256

    environment = [
      {
        name  = "DB_TYPE",
        value = "mysql"
      },
      {
        name  = "DB_HOST",
        value = aws_rds_cluster.app.endpoint
      },
      {
        name  = "DB_PORT",
        value = "3306"
      },
      {
        name  = "DB_NAME",
        value = "books"
      },
      {
        name  = "DB_USER",
        value = "apiuser"
      },
      {
        name  = "DB_PASS",
        value = "apipassword"
      },
      {
        name  = "LOG_LEVEL"
        value = "DEBUG"
      }
    ]
    portMappings = [
      {
        containerPort = 9000
        protocol      = "tcp"
        hostPort      = 9000
      }
    ],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-region" : "${var.region}",
        "awslogs-group" : "${local.service_name}",
        "awslogs-stream-prefix" : "${aws_ecs_cluster.app.name}"
      }
    }
  }]



}
