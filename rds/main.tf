
provider "aws" {
    region = "ap-southeast-1"
  
}

module "aws_db_instance" "source" {
source             = "terraform-aws-modules/rds/aws"
identifier         = "source"
allocated_storage  = 20
engine             = "mysql"
engine_version     = "8.0.23"
instance_class     = "db.t2.micro"
name               = "mydb"
username           = "admin"
password           = var.db_password
vpc_security_group_ids = [module.aws_security_group.default.id]
db_subnet_group_name   = module.aws_db_subnet_group.default.id
skip_final_snapshot    = true
}

module "aws_db_instance" "replica1" {
source             = "terraform-aws-modules/rds/aws"
identifier         = "replica1"
allocated_storage  = 20
engine             = "mysql"
engine_version     = "8.0.23"
instance_class     = "db.t2.micro"
name               = "mydb"
username           = "admin"
password           = var.db_password
vpc_security_group_ids = [module.aws_security_group.default.id]
db_subnet_group_name   = module.aws_db_subnet_group.default.id
skip_final_snapshot    = true
replicate_source_db    = module.aws_db_instance.source.identifier
}
