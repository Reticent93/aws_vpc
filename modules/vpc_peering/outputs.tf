output "peering_connection_id" {
  description = "ID of the VPC peering connection"
  value       = aws_vpc_peering_connection.vpc-connection.id
}

output "peering_connection_status" {
  description = "Status of the VPC peering connection"
  value       = aws_vpc_peering_connection.vpc-connection.accept_status
}

