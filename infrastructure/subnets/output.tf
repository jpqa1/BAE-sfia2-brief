output "database_subnet_group" {
  value = aws_db_subnet_group.private_subnet_group.name
}

output "jenkins-interface" {
  value = aws_network_interface.jenkins-interface.id
}

# output "bastion-interface" {
#   value = aws_network_interface.bastion-interface.id
# }

output "jenkins-priv-ips" {
  value = aws_network_interface.jenkins-interface.private_ips
}

output "docker-priv-ips" {
  value = aws_network_interface.docker-interface.private_ips
}

output "test-priv-ips" {
  value = aws_network_interface.test-interface.private_ips
}

output "docker-interface" {
  value = aws_network_interface.docker-interface.id
}

output "test-interface" {
  value = aws_network_interface.test-interface.id
}
