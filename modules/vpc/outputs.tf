output "vpc_id" {
  description   = "The ID of the VPC"
  value = aws_vpc.main.id
}

output "vpc_cidr" {
    description = "The CIDR block of the VPC"
  value = aws_vpc.main.cidr_block
}

output "igw_id" {
    description = "The ID of the Internet Gateway"
  value = aws_internet_gateway.main.id
}

output "web_security_group_id" {
    description = "The ID of the web security group"
  value = aws_security_group.web.id
}

