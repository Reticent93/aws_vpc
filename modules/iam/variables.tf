variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "trusted_entities" {
  description = "Services that can assume this role"
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket to grant access to"
  type        = string
}

variable "iam_policy_arns" {
  description = "List of managed policy ARNs to attach"
  type        = list(string)
  default     = []
}