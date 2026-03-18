resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}


resource "aws_lb_listener" "internal_listener" {
  load_balancer_arn = aws_lb.backend_app_lb.arn
  port              = 8000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

#resource "aws_lb_listener" "https" {
# load_balancer_arn = aws_lb.app_lb.arn
# port              = 443
# protocol          = "HTTPS"
# ssl_policy        = "ELBSecurityPolicy-2016-08"
# certificate_arn   = "arn:aws:acm:region:account:certificate/xxxx"

# default_action {
#   type             = "forward"
#   target_group_arn = aws_lb_target_group.frontend_tg.arn
# }
#}