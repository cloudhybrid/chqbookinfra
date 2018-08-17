resource "aws_alb_target_group" "target_group" {
  name                 = "${var.target_group_name}"
  port                 = "${var.backend_port}"
  protocol             = "${upper(var.backend_protocol)}"
  vpc_id               = "${var.vpc_id}"

  health_check {
    interval            = "${var.health_check_interval}"
    path                = "${var.health_check_path}"
    port                = "${var.health_check_port}"
    timeout             = "${var.health_check_timeout}"
    protocol            = "${var.backend_protocol}"
    matcher             = "${var.health_check_matcher}"
  }

  target_type = "${var.target_type}"

  tags = "${merge(var.tags, map("Name", "${var.target_group_name}-tg"))}"

  #depends_on = ["aws_alb.main"]
}
