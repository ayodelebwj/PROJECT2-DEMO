resource "aws_db_instance" "postgres" {
  identifier              = var.db_identifier
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  storage_type            = var.db_storage_type

  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  port                    = var.db_port

  publicly_accessible     = false
  skip_final_snapshot     = true

  backup_retention_period = 7
  multi_az                = false

  tags = {
    Name = var.db_tags_Name
    Environment = var.db_tags_Environment
  }
}