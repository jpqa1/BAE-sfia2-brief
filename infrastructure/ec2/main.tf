resource "aws_instance" "jenkins" {
  ami               = "ami-096cb92bb3580c759" # us-west-2
  instance_type     = "t2.medium"
  availability_zone = "eu-west-2a"
  #   user_data         = <<-EOF
  #                  #!/bin/bash
  #                  sudo apt update -y
  #                  sudo apt install apache2 -y
  #                  sudo systemctl start apache2
  #                  sudo bash -C 'echo my first webserver'
  #                  EOF

  #   network_interface {
  #     network_interface_id = var.network_int_id
  #     device_index         = 0
  #   }

  tags = {
    Name = "jenkins"
  }

}


resource "aws_instance" "docker" {
  ami               = "ami-096cb92bb3580c759" # us-west-2
  instance_type     = "t2.medium"
  availability_zone = "eu-west-2a"
  #   user_data         = <<-EOF
  #                  #!/bin/bash
  #                  sudo apt update -y
  #                  sudo apt install apache2 -y
  #                  sudo systemctl start apache2
  #                  sudo bash -C 'echo my first webserver'
  #                  EOF

  #   network_interface {
  #     network_interface_id = var.network_int_id
  #     device_index         = 0
  #   }

  tags = {
    Name = "deployment"
  }

}


resource "aws_instance" "test" {
  ami               = "ami-096cb92bb3580c759" # us-west-2
  instance_type     = "t2.medium"
  availability_zone = "eu-west-2a"
  #   user_data         = <<-EOF
  #                  #!/bin/bash
  #                  sudo apt update -y
  #                  sudo apt install apache2 -y
  #                  sudo systemctl start apache2
  #                  sudo bash -C 'echo my first webserver'
  #                  EOF

  #   network_interface {
  #     network_interface_id = var.network_int_id
  #     device_index         = 0
  #   }

  tags = {
    Name = "test"
  }

}

resource "aws_instance" "bastion" {
  ami               = "ami-096cb92bb3580c759" # us-west-2
  instance_type     = "t2.medium"
  availability_zone = "eu-west-2a"
  user_data         = <<-EOF
                   #!/bin/bash
                   sudo apt update -y
                   sudo apt install software-properties-common
                   sudo apt-add-repository --yes --update ppa:ansible/ansible
                   sudo apt install ansible -y
                   EOF

  #   network_interface {
  #     network_interface_id = var.network_int_id
  #     device_index         = 0
  #   }

  tags = {
    Name = "bastion"
  }

}

resource "aws_db_instance" "database" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "root"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  tags = {
    Name = "database"
  }
}
