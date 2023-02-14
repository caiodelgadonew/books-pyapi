# tfsec:ignore:aws-rds-specify-backup-retention
# tfsec:ignore:aws-rds-encrypt-cluster-storage-data
resource "aws_rds_cluster" "app" {
  cluster_identifier     = "aurora-${local.service_name}"
  engine                 = "aurora-mysql"
  engine_version         = "5.7.mysql_aurora.2.11.0"
  database_name          = "books"
  master_username        = "apiuser"
  master_password        = "apipassword"
  skip_final_snapshot    = "true"
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  db_subnet_group_name   = aws_db_subnet_group.app.name

  availability_zones = [
    "${var.region}a",
    "${var.region}b"
  ]

  lifecycle {
    ignore_changes = [availability_zones]
  }

  tags = {
    Name = "${var.name}-${var.env}"
  }
}

# tfsec:ignore:aws-rds-enable-performance-insights
resource "aws_rds_cluster_instance" "app" {
  identifier           = "aurora-${local.service_name}"
  cluster_identifier   = aws_rds_cluster.app.id
  instance_class       = "db.t3.small"
  engine               = aws_rds_cluster.app.engine
  engine_version       = aws_rds_cluster.app.engine_version
  db_subnet_group_name = aws_db_subnet_group.app.name
}


resource "aws_db_subnet_group" "app" {
  name       = local.resource_name
  subnet_ids = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]

  tags = {
    Name = "${local.resource_name}-dbgroup"
  }
}
