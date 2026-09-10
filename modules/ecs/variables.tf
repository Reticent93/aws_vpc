variable "aws_region" {
  description = "AWS region where the ECS cluster will be created"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the ECS cluster will be created"
  type        = string
}

variable "image_uri" {
  description = "Docker image URI for the container"
  type        = string
}

variable "container_port" {
  description = "Port on which the container will listen"
  type        = number
  default = 8081
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running"
  type        = number
  default = 1
}

variable "cpu" {
  description = "Number of cpu units used by the task"
  default = "256"
}

variable "memory" {
  description = "Amount (in MiB) of memory used by the task"
  default = "512"
}

variable "log_retention_days" {
  description = "Number of days the logs will be retained in CloudWatch"
  default = 7
}

variable "subnet_ids" {
  description = "Subnets where the ECS cluster will be created"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ID of the security group for the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group to associate with the load balancer"
  type        = string
}