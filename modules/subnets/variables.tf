variable "project_name" {
    description = "Name of the project"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "igw_id" {
    description = "ID of the Internet Gateway"
    type        = string
}

variable "public_subnet_cidrs" {
    description = "CIDR block for the public subnets"
    type        = list(string)
}

variable "private_subnet_cidrs" {
    description = "CIDR block for the private subnet"
    type        = list(string)
}

variable "availability_zones" {
    description = "Availability zones to use"
    type        = list(string)
}
