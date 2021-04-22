output "docker_ip" {
  value = aws_instance.docker.public_ip
}
output "test_ip" {
  value = aws_instance.test.public_ip
}
output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
}

# output "bastion_ip" {
#   value = aws_instance.bastion.public_ip
# }
