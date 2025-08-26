variable "vpc_id_1" {
  description = "ID of the first VPC"
  type        = string
}

variable "vpc_id_2" {
  description = "ID of the second VPC"
  type        = string
}

variable "vpc1_route_table_id" {
  description = "Route table ID for VPC 1"
  type        = string
}

variable "vpc2_route_table_id" {
  description = "Route table ID for VPC 2"
  type        = string
}

variable "cidr_vpc1" {
  description = "CIDR block for VPC 1"
  type        = string
}

variable "cidr_vpc2" {
  description = "CIDR block for VPC 2"
  type        = string
}

