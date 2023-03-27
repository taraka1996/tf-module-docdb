resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "${var.env}-docdb"
  engine                  =  var.engine
  engine_version = var.engine_version
  master_username         = data.aws_ssm_parameter.user.value
  master_password         = data.aws_ssm_parameter.pass
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = true
  db_subnet_group_name = aws_docdb_subnet_group.main.name
  kms_key_id = data.aws_kms_key.arn
  storage_encrypted = true
  
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = var.no_of_instances
  identifier         = "${var.env}-docdb-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = var.instance_class
}

resource "aws_docdb_subnet_group" "main" {
    name = "${var.env}-docdb"
    subnet_ids = var.subnet_ids

    tags = merge(
      var.tags,
        { Name = "${var.env}-subnet-group" }
    )
}