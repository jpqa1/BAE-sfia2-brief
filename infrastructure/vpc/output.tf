output "vpc_id" {
  value = aws_vpc.production_vpc.id
}

output "route_id" {
  value = aws_route_table.prod_route.id
}

output "internet_gate" {
  value = aws_internet_gateway.gw
}

output "sec_group_id" {
  value = aws_security_group.allow_web.id
}
output "db_sec_group_id" {
  value = aws_security_group.MySQL-SecurityGroup.id
}
