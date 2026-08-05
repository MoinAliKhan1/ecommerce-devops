# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "ecommerce-nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main" {

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "ecommerce-nat-gateway"
  }

  depends_on = [
    aws_internet_gateway.main
  ]
}

# Private Route Table
resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecommerce-private-route-table"
  }
}

# Default Route to NAT Gateway
resource "aws_route" "private_internet_access" {

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

# Associate Private Subnet 1
resource "aws_route_table_association" "private_subnet_1" {

  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

# Associate Private Subnet 2
resource "aws_route_table_association" "private_subnet_2" {

  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}
