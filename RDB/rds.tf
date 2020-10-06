terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = ">= 2.28.1"
  region  = "ap-southeast-2"
}

resource "aws_subnet" "main-new" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "main"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "thisisatest"
  parameter_group_name = "default.mysql5.7"
  
}

