# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Random suffix for unique S3 bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Create S3 Bucket first (needed for IAM policy)
module "aws_s3_bucket" {
  source            = "./modules/s3"
  s3_bucket_name       = var.s3_bucket_name != null ? var.s3_bucket_name : "${var.project_name}-shared-${random_id.bucket_suffix.hex}"
  project_name      = var.project_name
  aws_s3_bucket_versioning = "Enabled"
}

# Create VPCs (includes security groups)
module "vpc1" {
  source       = "./modules/vpc"
  project_name = "${var.project_name}-primary"
  vpc_cidr     = var.vpc_configs.vpc1.cidr_block
  security_group_rules = {
    web_ingress_ports = var.security_group_config.web_ports
    ssh_cidr_blocks   = var.security_group_config.ssh_cidr_blocks
    egress_all        = var.security_group_config.allow_all_egress
  }
}

module "vpc2" {
  source       = "./modules/vpc"
  project_name = "${var.project_name}-secondary"
  vpc_cidr     = var.vpc_configs.vpc2.cidr_block
  security_group_rules = {
    web_ingress_ports = var.security_group_config.web_ports
    ssh_cidr_blocks   = var.security_group_config.ssh_cidr_blocks
    egress_all        = var.security_group_config.allow_all_egress
  }
}
# Create Subnets
module "subnet_vpc1" {
  source               = "./modules/subnets"
  project_name         = "${var.project_name}-primary"
  vpc_id               = module.vpc1.vpc_id
  igw_id               = module.vpc1.igw_id
  availability_zones   = var.availability_zones
  public_route_table_id   = module.vpc1.public_route_table_id
  private_route_table_id  = module.vpc1.private_route_table_id
  public_subnet_cidrs  = var.vpc_configs.vpc1.public_subnet_cidrs
  private_subnet_cidrs = var.vpc_configs.vpc1.private_subnet_cidrs
}

module "subnet_vpc2" {
  source               = "./modules/subnets"
  project_name         = "${var.project_name}-secondary"
  vpc_id               = module.vpc2.vpc_id
  igw_id               = module.vpc2.igw_id
  availability_zones   = var.availability_zones
  public_route_table_id   = module.vpc2.public_route_table_id
  private_route_table_id  = module.vpc2.private_route_table_id
  public_subnet_cidrs  = var.vpc_configs.vpc2.public_subnet_cidrs
  private_subnet_cidrs = var.vpc_configs.vpc2.private_subnet_cidrs
}

# Create IAM Role for EC2 (with S3 access)
module "iam_role" {
  source          = "./modules/iam"
  project_name    = var.project_name
  iam_role_name   = "${var.project_name}-ec2-role"
  s3_bucket_arn   = module.aws_s3_bucket.bucket_arn
  trusted_entities = ["ec2.amazonaws.com"]

  # Basic managed policies
  iam_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

  # VPC Peering (Optional)
  module "vpc_peering" {
    count               = var.enable_vpc_peering ? 1 : 0
    source              = "./modules/vpc_peering"
    vpc_id_1            = module.vpc1.vpc_id
    vpc_id_2            = module.vpc2.vpc_id
    cidr_vpc1           = var.vpc_configs.vpc1.cidr_block
    cidr_vpc2           = var.vpc_configs.vpc2.cidr_block
    vpc1_route_table_id = module.vpc1.public_route_table_id
    vpc2_route_table_id = module.vpc2.public_route_table_id
  }

module "ec2_vpc1" {
  count = var.enable_ec2 ? 1 : 0
  source                 = "./modules/ec2"
  instance_name          = "${var.project_name}-primary-web"
  ami_id                 = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = module.subnet_vpc1.public_subnet_ids[0]
  vpc_security_group_ids = [module.vpc1.web_security_group_id]
  iam_instance_profile   = module.iam_role.instance_profile_name
  key_name               = var.key_name
}

module "alb" {
  source                = "./modules/alb"
  project_name          = var.project_name
  vpc_id                = module.vpc1.vpc_id
  subnets = module.subnet_vpc1.public_subnet_ids
  container_port = var.container_port
  health_check_path = var.health_check_path
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "ecs" {
  source     = "./modules/ecs"
  aws_region = var.aws_region
  container_port        = var.container_port
  cpu                   = var.cpu
  desired_count         = var.desired_count
  image_uri             = "${module.ecr.repository_url}:${var.image_tag}"
  log_retention_days    = var.log_retention_days
  memory                = var.memory
  project_name          = var.project_name
  vpc_id                = module.vpc1.vpc_id
  alb_security_group_id = module.alb.security_group_id
  subnet_ids = module.subnet_vpc1.public_subnet_ids
  target_group_arn      = module.alb.target_group_arn

  depends_on = [module.alb]
}