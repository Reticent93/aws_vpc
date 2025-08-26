project_name = "aws-terraform-multi-vpc"

aws_region = "us-east-1"

availability_zones = ["us-east-1a", "us-east-1b"]


# S3 Configuration
s3_bucket_name      = "aws-terraform-multi-vpc-4412"
create_s3_bucket = true
s3_allowed_actions = [
  "s3:PutObject",
  "s3:GetObject",
  "s3:DeleteObject"
]

# IAM Configuration
create_bucket_policy = true


# CloudWatch Logs Configuration
create_log_group    = true
log_retention_days  = 14


# Tags
common_tags = {
  Owner        = "devops-team"
  CostCenter   = "engineering"
  Project      = "web-application"
  Environment  = "dev"
  BackupPolicy = "weekly"
  Compliance   = "none"
}

# VPC CIDR blocks
vpc_configs = {
  vpc1 = {
    cidr_block = "10.0.0.0/16"
    public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
  }

  vpc2 = {
    cidr_block = "10.1.0.0/16"
    public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
    private_subnet_cidrs = ["10.1.10.0/24", "10.1.20.0/24"]
  }
}

# Security group rules
security_group_config = {
  web_ports = [80, 443, 8080]
  ssh_cidr_blocks = [
    "10.0.0.0/8",     # Private networks
    "203.0.113.0/24"  # Office IP range test
  ]
  allow_all_egress = true
}


instance_type = "t2.micro"
key_name = "my-ec2-ssh-key"

# Enable VPC Peering
enable_vpc_peering = true
