resource "aws_instance" "jenkins" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.key_name
  user_data         = <<-EOF
                   #!/bin/bash
                   sudo apt update -y
                   EOF

  network_interface {
    network_interface_id = var.network_id_jenk
    device_index         = 0
  }

  tags = {
    Name = "jenkins"
  }

}


resource "aws_instance" "docker" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.key_name
  user_data         = <<-EOF
                   #!/bin/bash
                   sudo apt update -y
                   EOF

  network_interface {
    network_interface_id = var.network_id_dock
    device_index         = 0
  }

  tags = {
    Name = "docker"
  }

}


resource "aws_instance" "test" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = var.key_name
  user_data         = <<-EOF
                   #!/bin/bash
                   sudo apt update -y
                   EOF

  network_interface {
    network_interface_id = var.network_id_test
    device_index         = 0
  }

  tags = {
    Name = "test"
  }

}

# resource "aws_instance" "bastion" {
#   ami               = "ami-096cb92bb3580c759" # us-west-2
#   instance_type     = "t2.medium"
#   availability_zone = "eu-west-2a"
#   user_data         = <<-EOF
#                    #!/bin/bash
#                    sudo apt update -y
#                    sudo apt install software-properties-common
#                    sudo apt-add-repository --yes --update ppa:ansible/ansible
#                    sudo apt install ansible -y
#                    EOF

#   #   network_interface {
#   #     network_interface_id = var.network_int_id
#   #     device_index         = 0
#   #   }

#   tags = {
#     Name = "bastion"
#   }

# }

resource "aws_db_instance" "database" {
  identifier             = "mydb"
  name                   = "mydb"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = "root"
  password               = var.database_password
  db_subnet_group_name   = var.subnet_group_name
  vpc_security_group_ids = [var.security_group_id]
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  publicly_accessible    = false
  tags = {
    Name = "database"
  }
}
