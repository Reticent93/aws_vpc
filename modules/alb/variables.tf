variable "vpc_id" {
  description = "ID of the VPC where the ALB will be created"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "subnets" {
  description = "List of subnets where the ALB will be created"
  type        = list(string)
}

variable "container_port" {
  description = "Port on which the ALB will listen for traffic"
  type        = number
}

variable "health_check_path" {
  type    = string
  default = "/health"
}
