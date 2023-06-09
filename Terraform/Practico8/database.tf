resource "aws_db_instance" "db" {
  allocated_storage       = 10
  db_name                 = var.rds_dbname
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  username                = var.rds_user
  password                = var.rds_password
  parameter_group_name    = "default.mysql5.7"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.db_group.name
  vpc_security_group_ids  = [aws_security_group.sg_webserver.id]

}
