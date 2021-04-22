provider "aws" {
  region     = "eu-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"

  vpc_id        = module.vpc.vpc_id
  route_id      = module.vpc.route_id
  sec_group_id  = module.vpc.sec_group_id
  internet_gate = module.vpc.internet_gate
}

module "ec2" {
  source = "./ec2"

  network_id_jenk = module.subnets.jenkins-interface
  network_id_dock = module.subnets.docker-interface
  network_id_test = module.subnets.test-interface
  # network_id_bast   = module.subnets.bastion-interface
  ami_id            = "ami-096cb92bb3580c759"
  instance_type     = "t2.medium"
  availability_zone = "eu-west-2a"
  key_name          = "ssh-aws-pc"
  security_group_id = module.vpc.db_sec_group_id
  subnet_group_name = module.subnets.database_subnet_group
  database_password = var.database_password
}

resource "local_file" "tf_ansible_inventory" {
  content  = <<-DOC
    all:
      children:
        docker:
          hosts:
            ${module.ec2.dock_ip}: #docker
          vars:
            ansible_ssh_private_key_file: "~/.ssh/ssh-aws-pc"
            ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
            ansible_user: ubuntu
        jenkins:
          hosts:
            ${module.ec2.jenk_ip}: #Jenkins
          vars:
            ansible_ssh_private_key_file: "~/.ssh/ssh-aws-pc"
            ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
            ansible_user: ubuntu
        test:
          hosts:
            ${module.ec2.test_ip}: #test
          vars:
            ansible_ssh_private_key_file: "~/.ssh/ssh-aws-pc"
            ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
            ansible_user: ubuntu
    DOC
  filename = "./inventory.yaml"
}
