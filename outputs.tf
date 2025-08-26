# Root outputs.tf

# S3 Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.aws_s3_bucket.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.aws_s3_bucket.bucket_arn
}


# IAM Module Outputs
output "iam_role_arn" {
  description = "ARN of the EC2 IAM role"
  value       = module.iam_role.role_arn
}

output "iam_role_name" {
  description = "Name of the EC2 IAM role"
  value       = module.iam_role.role_name
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = module.iam_role.instance_profile_name
}



# Configuration Summary
output "deployment_summary" {
  description = "Summary of the deployed infrastructure"
  value = {
    project_name         = var.project_name
    aws_region          = var.aws_region
    bucket_name         = var.s3_bucket_name
    bucket_created      = var.create_s3_bucket
    log_group_created   = var.create_log_group
    iam_role_name       = module.iam_role.role_name
  }
}

# Ready-to-use configuration for other services
output "application_config" {
  description = "Configuration values for application deployment"
  value = {
    s3_bucket           = module.aws_s3_bucket.bucket_name
    iam_instance_profile = module.iam_role.instance_profile_name
    aws_region          = var.aws_region
  }
  sensitive = false
}