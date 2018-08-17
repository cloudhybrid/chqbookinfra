resource "aws_lb" "test" {
  name               = "${var.name}"
  internal           = "${var.internal}"
  load_balancer_type = "application"
  security_groups    = ["${var.security_group_ids}"]
  subnets            = ["${var.alb_subnets}"]

  enable_deletion_protection = "${var.enable_deletion_protection}"

  tags {
    Name = "${var.name}"
    env = "${var.env}"
    project = "${var.project}"
    purpose = "${var.purpose}"
  }
}
