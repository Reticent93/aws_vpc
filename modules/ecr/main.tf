resource "aws_ecr_repository" "dock" {
  name = "${var.project_name}-ecr"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

