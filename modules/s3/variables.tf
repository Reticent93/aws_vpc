variable "project_name" {
    description = "Name of the project"
    type        = string
}

variable "s3_bucket_name" {
    description = "Name of the S3 bucket"
    type        = string
}

variable "aws_s3_bucket_versioning" {
    description = "Enable versioning for the S3 bucket"
    type        = string
    default     = "Enabled"
}