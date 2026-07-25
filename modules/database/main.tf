resource "aws_db_subnet_group" "db-subnetgroup" {
  name       = "main"
  subnet_ids = ["${var.aws-dbsubnetgroupAZ1}", "${var.aws-dbsubnetgroupAZ2}"]
  tags = {
    Name = "DBgroup"
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
}

resource "aws_rds_cluster" "multi_az_cluster" {
  cluster_identifier  = "db-cluster"
  engine              = "mysql"
  # Deploys as a Multi-AZ Cluster (1 writer, 2 readable standbys)
  # instead of an Aurora cluster
  
  engine_mode         = "provisioned" 
  db_cluster_instance_class = "t3.small"
  db_subnet_group_name   = aws_db_subnet_group.db-subnetgroup.name
  vpc_security_group_ids = ["${var.aws-db-security-group}"]
  master_username        = "db_admin"
  master_password        = "admin1234"
  skip_final_snapshot    = true
}*/