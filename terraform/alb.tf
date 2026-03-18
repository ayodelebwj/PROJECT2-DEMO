resource "aws_lb" "app_lb" {
  name               = "my-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [data.aws_subnet.public_subnet.id, data.aws_subnet.public_subnet_2.id]
}

resource "aws_lb" "backend_app_lb" {
  name               = "backend-alb"
  load_balancer_type = "application"
  internal = true
  security_groups    = [aws_security_group.backend_alb_sg.id]
  subnets            = [data.aws_subnet.private_subnet.id, data.aws_subnet.private_subnet_2.id]
}