output "database_subnet_group" {
  value = aws_db_subnet_group.private_subnet_group.name
}

output "jenkins-interface" {
  value = aws_network_interface.jenkins-interface.id
}

output "docker-interface" {
  value = aws_network_interface.docker-interface.id
}

output "test-interface" {
  value = aws_network_interface.test-interface.id
}
