resource "aws_subnet" "public" {
  count      = length(var.public_subnet_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.public_subnet_cidrs[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
    type = "public"
  }

}

resource "aws_subnet" "private" {
  count        = length(var.private_subnet_cidrs)
  vpc_id       = var.vpc_id
  cidr_block   = var.private_subnet_cidrs[count.index]

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
    type = "private"
  }
}


resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}



resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = var.private_route_table_id
}

