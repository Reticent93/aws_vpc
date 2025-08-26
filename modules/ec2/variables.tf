variable "instance_name" {
    description = "Name for the EC2 instance"
    type        = string
}

variable "instance_type" {
    description = "Type of EC2 instance"
    type        = string
    default     = "t2.micro"
}

variable "ami_id" {
    description = "AMI ID for the instance"
    type        = string
}

variable "subnet_id" {
    description = "Subnet ID to launch instance in"
    type        = string
}

variable "vpc_security_group_ids" {
    description = "Security group IDs"
    type        = list(string)
}

variable "iam_instance_profile" {
    description = "IAM instance profile name"
    type        = string
    default     = null
}

variable "key_name" {
    description = "EC2 Key Pair name"
    type        = string
    default     = null
}


variable "enable_vpc_peering" {
    description = "Enable VPC peering between vpc1 and vpc2"
    type        = bool
    default     = true
}