resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = var.project_name
    }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  # Route for internet access
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}


# Private Route Table (no internet access by default)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}


resource "aws_security_group" "web" {
  description = "Security group for web servers"
  name_prefix = "${var.project_name}-web-sg"
  vpc_id      = aws_vpc.main.id


  dynamic "ingress" {
    for_each = var.security_group_rules.web_ingress_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.security_group_rules.ssh_cidr_blocks
  }



  dynamic "egress" {
    for_each = var.security_group_rules.egress_all ? [1] : []
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "${var.project_name}-web-sg"
  }
}


