resource "aws_instance" "web-app" {
  ami                    = data.aws_ami.rhel.id
  instance_type          = var.instance_type["dev"]
  key_name               = var.key_name
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.web.id]

  tags = {
    Name = "${local.my_name}-web-app"
  }
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type["dev"]
  subnet_id              = data.terraform_remote_state.network.outputs.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.app.id]

  tags = {
    Name = "${local.my_name}-app"
  }
}

#create a RDS Database Instance
resource "aws_db_instance" "infra-db" {
  engine                 = "mysql"
  identifier             = "myrdsinstance"
  allocated_storage      = 20
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "myrdsuser"
  password               = "myrdspassword"
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = data.terraform_remote_state.network.outputs.db_subnet_group
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "${local.my_name}-infra-db"
  }

}
