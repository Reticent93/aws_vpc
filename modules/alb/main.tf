
resource "aws_lb" "alb" {
  name = "${var.project_name}-alb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = var.subnets
  drop_invalid_header_fields = true
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name = "${var.project_name}-tg"
  port = var.container_port
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "ip"

  health_check {
    path = var.health_check_path
    port = "traffic-port"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 6
    matcher = "200"
  }
}

resource "aws_security_group" "alb" {
  name = "${var.project_name}-apps-sg"
  description = "Security group for apps"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-app-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.alb.id
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}