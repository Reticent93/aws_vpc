variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"
}

variable "project_name" {
    description = "Name of the project"
    type        = string
}

variable "availability_zones" {
    description = "Availability zones to use"
    type        = list(string)
}

variable "vpc_configs" {
    description = "Configuration for VPCs"
    type = object({
        vpc1 = object({
            cidr_block           = string
            public_subnet_cidrs  = list(string)
            private_subnet_cidrs = list(string)
        })
        vpc2 = object({
            cidr_block           = string
            public_subnet_cidrs  = list(string)
            private_subnet_cidrs = list(string)
        })
    })
}

variable "instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t3.micro"
}

variable "key_name" {
    description = "EC2 Key Pair name"
    type        = string
    default     = null
}

variable "s3_bucket_name" {
    description = "Name for the S3 bucket (must be globally unique)"
    type        = string
    default     = null  # Will auto-generate if not provided
}

variable "create_s3_bucket" {
    description = "Whether to create S3 bucket"
    type        = bool
    default     = true
}

variable "s3_allowed_actions" {
    description = "Allowed S3 actions"
    type        = list(string)
    default     = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
}

variable "create_bucket_policy" {
    description = "Whether to create bucket policy"
    type        = bool
    default     = true
}

variable "create_log_group" {
    description = "Whether to create CloudWatch log group"
    type        = bool
    default     = false
}

variable "log_retention_days" {
    description = "CloudWatch log retention in days"
    type        = number
    default     = 14
}

variable "common_tags" {
    description = "Common tags for all resources"
    type        = map(string)
    default     = {}
}

variable "security_group_config" {
    description = "Security group configuration"
    type = object({
        web_ports           = list(number)
        ssh_cidr_blocks     = list(string)
        allow_all_egress    = bool
    })
    default = {
        web_ports        = [80, 443]
        ssh_cidr_blocks  = ["0.0.0.0/0"]
        allow_all_egress = true
    }
}

variable "enable_vpc_peering" {
    description = "Enable VPC peering"
    type        = bool
    default     = false
}