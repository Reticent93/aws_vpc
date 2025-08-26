# Create the VPC Peering Connection
resource "aws_vpc_peering_connection" "vpc-connection" {
  vpc_id      = var.vpc_id_1
  peer_vpc_id = var.vpc_id_2
  auto_accept = true

  tags = {
    Name = "VPC Peering Connection"
  }
}

# Add route in VPC 1 to reach VPC 2
resource "aws_route" "vpc1_to_vpc2" {
  route_table_id            = var.vpc1_route_table_id
  destination_cidr_block    = var.cidr_vpc2
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-connection.id
}

# Add route in VPC 2 to reach VPC 1
resource "aws_route" "vpc2_to_vpc1" {
  route_table_id            = var.vpc2_route_table_id
  destination_cidr_block    = var.cidr_vpc1
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc-connection.id
}