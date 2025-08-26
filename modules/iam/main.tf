# IAM Role for EC2 instances
resource "aws_iam_role" "iam_role" {
    name = var.iam_role_name

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = var.trusted_entities
                }
                Action = "sts:AssumeRole"
            }
        ]
    })

    tags = {
        Name    = var.iam_role_name
        Project = var.project_name
    }
}

# S3 access policy for the bucket
resource "aws_iam_policy" "s3_access" {
    name        = "${var.iam_role_name}-s3-access"
    description = "Policy allowing S3 access to project bucket"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "s3:GetObject",
                    "s3:PutObject",
                    "s3:DeleteObject",
                    "s3:ListBucket"
                ]
                Resource = [
                    var.s3_bucket_arn,
                    "${var.s3_bucket_arn}/*"
                ]
            }
        ]
    })
}

# Attach managed policies (like SSM)
resource "aws_iam_role_policy_attachment" "managed_policies" {
    count      = length(var.iam_policy_arns)
    role       = aws_iam_role.iam_role.name
    policy_arn = var.iam_policy_arns[count.index]
}

# Attach S3 policy
resource "aws_iam_role_policy_attachment" "s3_access" {
    role       = aws_iam_role.iam_role.name
    policy_arn = aws_iam_policy.s3_access.arn
}

# Instance profile for EC2 instances
resource "aws_iam_instance_profile" "instance_profile" {
    name = "${var.iam_role_name}-instance-profile"
    role = aws_iam_role.iam_role.name

    tags = {
        Name    = "${var.iam_role_name}-instance-profile"
        Project = var.project_name
    }
}