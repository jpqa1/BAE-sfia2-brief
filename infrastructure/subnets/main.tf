resource "aws_subnet" "public-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
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
#   subnet_id      = aws_subnet.public.id
#   route_table_id = var.route_id

# }

resource "aws_db_subnet_group" "private_subnet_group" {
  name       = "private_group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  tags = {
    Name = "private_subnet_group"
  }
}

resource "aws_network_interface" "test" {

  subnet_id       = aws_subnet.public.id
  private_ips     = ["10.0.1.50", "10.0.1.51"]
  security_groups = [var.security_id]

}

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.test.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [var.internet_gate]
}
