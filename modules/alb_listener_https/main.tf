resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${var.load_balancer_arn}"
  port              = "${var.port}"
  protocol          = "${var.protocol}"
  certificate_arn   = "${var.certificate_arn}"
  ssl_policy        = "${var.security_policy}"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }

}
