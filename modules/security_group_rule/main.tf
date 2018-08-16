resource "aws_security_group_rule" "sg_rule" {
  type              = "${var.type}"
  to_port           = "${var.to_port}"
  from_port         = "${var.from_port}"
  protocol          = "${var.protocol}"
  cidr_blocks       = ["${var.cidr_block}"]
  security_group_id = "${var.security_group_id}"
}
