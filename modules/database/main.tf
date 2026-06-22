resource "aws_db_subnet_group" "db-subnetgroup" {
  name       = "main"
  subnet_ids = ["${var.aws-dbsubnetgroupAZ1}", "${var.aws-dbsubnetgroupAZ2}"]

  tags = {
    Name = "My DB subnet group"
  }
}
/*
resource "aws_rds_cluster" "aws-db-cluster" {
  cluster_identifier      = "aurora-multi-az-cluster"
  engine                    = "mysql"
  db_cluster_instance_class = "db.t3.small"
  storage_type              = "io1"
  allocated_storage         = 50
  database_name             = "db1"
  master_username           = "admin"
  master_password           = "admin1234"
  db_subnet_group_name = aws_db_subnet_group.db-subnetgroup.name
  vpc_security_group_ids = [ "${var.aws-securitygroup}"]
}*/
