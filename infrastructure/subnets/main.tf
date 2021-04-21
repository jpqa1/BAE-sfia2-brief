resource "aws_subnet" "public-subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2c"
  tags = {
    Name = "private_subnet"
  }
}

# resource "aws_route_table_association" "public_association" {
#   subnet_id      = aws_subnet.public-subnet.id
#   route_table_id = var.route_id

# }

resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "private_group"
  subnet_ids = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

  tags = {
    Name = "private_subnet_group"
  }
}


resource "aws_network_interface" "jenkins-interface" {

  subnet_id       = aws_subnet.public-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [var.sec_group_id]

}

resource "aws_network_interface" "docker-interface" {

  subnet_id       = aws_subnet.public-subnet.id
  private_ips     = ["10.0.1.51"]
  security_groups = [var.sec_group_id]

}

resource "aws_network_interface" "test-interface" {

  subnet_id       = aws_subnet.public-subnet.id
  private_ips     = ["10.0.1.52"]
  security_groups = [var.sec_group_id]

}

# resource "aws_eip" "elastic-ip-one" {
#   vpc                       = true
#   network_interface         = aws_network_interface.public-interface.id
#   associate_with_private_ip = "10.0.1.50"
#   depends_on                = [var.internet_gate]
# }

resource "aws_eip" "nat-gw-elastic" {
  vpc        = true
  depends_on = [var.internet_gate]
}

resource "aws_nat_gateway" "nat-gateway" {

  depends_on = [
    aws_eip.nat-gw-elastic
  ]

  allocation_id = aws_eip.nat-gw-elastic.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "nat gateway"
  }
}

resource "aws_route_table" "nat-route-table" {
  depends_on = [
    aws_nat_gateway.nat-gateway
  ]

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "route table for private nat"
  }
}

resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = var.route_id
}

resource "aws_route_table_association" "private-subnet-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.nat-route-table.id
}

resource "aws_route_table_association" "private-subnet-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.nat-route-table.id
}
