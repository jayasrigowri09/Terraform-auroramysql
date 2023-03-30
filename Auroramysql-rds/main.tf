
//create RDS Aurora Cluster
resource "aws_rds_cluster" "aurora_cluster" {
  engine                              = var.engine
  engine_mode                         = var.engine_mode
  engine_version                      = var.engine_version
  cluster_identifier                  = var.cluster_identifier
  master_username                     = var.master_username
  master_password                     = var.master_password
  database_name                       = var.database_name
  port                                = var.port
  skip_final_snapshot                 = var.skip_final_snapshot
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  deletion_protection                 = var.deletion_protection
  db_subnet_group_name                = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.database_security_group.id]


}
// create writer instance
resource "aws_rds_cluster_instance" "writer_instance" {
  identifier              = "${var.cluster_identifier}-example-instance"
  cluster_identifier      = join("", aws_rds_cluster.aurora_cluster.*.id)
  instance_class          = var.instance_class
  publicly_accessible     = var.publicly_accessible
  engine                  = aws_rds_cluster.aurora_cluster.engine
  engine_version          = aws_rds_cluster.aurora_cluster.engine_version
  db_parameter_group_name = aws_db_parameter_group.db_parameter_group.name
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  tags = {
    Name = "Aurora-Mysql-Writer"
  }
}
//create read Replicas
resource "aws_rds_cluster_instance" "reader_instance" {
  count                   = var.replica_enabled ? 3 : 1
  identifier              = "aurora-reader-${count.index}"
  cluster_identifier      = join("", aws_rds_cluster.aurora_cluster.*.id)
  instance_class          = var.instance_class
  publicly_accessible     = var.publicly_accessible
  engine                  = aws_rds_cluster.aurora_cluster.engine
  engine_version          = aws_rds_cluster.aurora_cluster.engine_version
  db_parameter_group_name = aws_db_parameter_group.db_parameter_group.name
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "-Aurora-Mysql.${count.index}"
  }
}
//RDS DB parameter group
resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "aurora-mysql-parameter-group"
  description = "Custom parameter group for MYSQL-Aurora"
  family      = "aurora-mysql5.7"
  parameter {
    name  = "connect_timeout"
    value = "4"
  }
  parameter {
    name  = "autocommit"
    value = "1"
  }
  tags = {
    Name = "example-db-parameter-group"
  }
}
//DB subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "subet-data-b"
  subnet_ids  = ["subnet-004baca42605a5737", "subnet-0a944d9b583e97446"]
  description = "subnet for database instance"
  tags = {
    Name = "aurora-db-subnet"
  }
}

//DB security group
resource "aws_security_group" "database_security_group" {
  name        = "Database-SecurityGroup"
  description = "Enable Amazon Aurora Mysql access"
  vpc_id      = "vpc-02a3ff0d29854fe27"
  ingress {
    description = "MYSQL/Aurora access"
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "Aurora-Db-security-group"
  }

}
