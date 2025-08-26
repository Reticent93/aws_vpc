output "public_subnet_ids" {
    description = "List of public subnet IDs"
    value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    description = "List of private subnet IDs"
    value       = aws_subnet.private[*].id
}

output "public_subnets" {
    description = "List of public subnet objects"
    value       = aws_subnet.public
}

output "private_subnets" {
    description = "List of private subnet objects"
    value       = aws_subnet.private
}

output "public_route_table_id" {
    description = "ID of the public route table"
    value       = aws_route_table.public.id
}