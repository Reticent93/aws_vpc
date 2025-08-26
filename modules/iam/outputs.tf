output "role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.iam_role
}

output "role_name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.iam_role
}

output "instance_profile_name" {
  description = "Name of the instance profile"
  value       = aws_iam_instance_profile.instance_profile.name
}