resource "aws_security_group" "odmont" {
  count = "${var.create ? 1 : 0}"

  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count = "${var.rule_create ? length(var.ingress_with_cidr_blocks) : 0}"

  security_group_id = "${aws_security_group.odmont.id}"
  type              = "ingress"

  cidr_blocks = ["${split(",", lookup(var.ingress_with_cidr_blocks[count.index], "cidr_blocks", join(",", var.ingress_cidr_blocks)))}"]
  description = "${lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")}"
  from_port   = "${lookup(var.ingress_with_cidr_blocks[count.index], "from_port", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 0))}"
  to_port     = "${lookup(var.ingress_with_cidr_blocks[count.index], "to_port", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 1))}"
  protocol    = "${lookup(var.ingress_with_cidr_blocks[count.index], "protocol", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 2))}"
}

resource "aws_security_group_rule" "ingress_rules" {
  count = "${var.rule_create ? length(var.ingress_rules) : 0}"

  security_group_id = "${aws_security_group.odmont.id}"
  type              = "ingress"

  description = "${element(var.rules[var.ingress_rules[count.index]], 3)}"

  from_port   = "${element(var.rules[var.ingress_rules[count.index]], 0)}"
  to_port     = "${element(var.rules[var.ingress_rules[count.index]], 1)}"
  protocol    = "${element(var.rules[var.ingress_rules[count.index]], 2)}"
  cidr_blocks = ["${element(var.rules[var.ingress_rules[count.index]], 4)}"]
}

resource "aws_security_group_rule" "existing_ingress_with_cidr_blocks" {
  count = "${var.existing_sg_rule_create ? length(var.ingress_with_cidr_blocks) : 0}"

  security_group_id = "${var.security_group_id}"
  type              = "ingress"

  cidr_blocks = ["${split(",", lookup(var.ingress_with_cidr_blocks[count.index], "cidr_blocks", join(",", var.ingress_cidr_blocks)))}"]
  description = "${lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")}"
  from_port   = "${lookup(var.ingress_with_cidr_blocks[count.index], "from_port", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 0))}"
  to_port     = "${lookup(var.ingress_with_cidr_blocks[count.index], "to_port", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 1))}"
  protocol    = "${lookup(var.ingress_with_cidr_blocks[count.index], "protocol", element(var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")], 2))}"
}

resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
  count = "${var.rule_create ? length(var.ingress_with_source_security_group_id) : 0}"

  security_group_id = "${aws_security_group.odmont.id}"
  type              = "ingress"

  source_security_group_id = "${lookup(var.ingress_with_source_security_group_id[count.index], "source_security_group_id")}"
  description              = "${lookup(var.ingress_with_source_security_group_id[count.index], "description", "Ingress Rule")}"
  from_port                = "${lookup(var.ingress_with_source_security_group_id[count.index], "from_port", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 0))}"
  to_port                  = "${lookup(var.ingress_with_source_security_group_id[count.index], "to_port", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 1))}"
  protocol                 = "${lookup(var.ingress_with_source_security_group_id[count.index], "protocol", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 2))}"
}

resource "aws_security_group_rule" "existing_ingress_with_source_security_group_id" {
  count = "${var.existing_sg_rule_create ? length(var.ingress_with_source_security_group_id) : 0}"

  security_group_id = "${var.security_group_id}"
  type              = "ingress"

  source_security_group_id = "${lookup(var.ingress_with_source_security_group_id[count.index], "source_security_group_id")}"
  description              = "${lookup(var.ingress_with_source_security_group_id[count.index], "description", "Ingress Rule")}"
  from_port                = "${lookup(var.ingress_with_source_security_group_id[count.index], "from_port", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 0))}"
  to_port                  = "${lookup(var.ingress_with_source_security_group_id[count.index], "to_port", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 1))}"
  protocol                 = "${lookup(var.ingress_with_source_security_group_id[count.index], "protocol", element(var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_")], 2))}"
}

resource "aws_security_group_rule" "computed_ingress_rules" {
  count = "${var.create ? var.number_of_computed_ingress_rules : 0}"

  security_group_id = "${aws_security_group.odmont.id}"
  type              = "ingress"

  cidr_blocks = ["${var.ingress_cidr_blocks}"]
  description = "${element(var.rules[var.computed_ingress_rules[count.index]], 3)}"

  from_port = "${element(var.rules[var.computed_ingress_rules[count.index]], 0)}"
  to_port   = "${element(var.rules[var.computed_ingress_rules[count.index]], 1)}"
  protocol  = "${element(var.rules[var.computed_ingress_rules[count.index]], 2)}"
}

resource "aws_security_group_rule" "computed_ingress_with_cidr_blocks" {
  count = "${var.create ? var.number_of_computed_ingress_with_cidr_blocks : 0}"

  security_group_id = "${aws_security_group.odmont.id}"
  type              = "ingress"

  cidr_blocks = ["${split(",", lookup(var.computed_ingress_with_cidr_blocks[count.index], "cidr_blocks", join(",", var.ingress_cidr_blocks)))}"]
  description = "${lookup(var.computed_ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")}"

  from_port = "${lookup(var.computed_ingress_with_cidr_blocks[count.index], "from_port", element(var.rules[lookup(var.computed_ingress_with_cidr_blocks[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.computed_ingress_with_cidr_blocks[count.index], "to_port", element(var.rules[lookup(var.computed_ingress_with_cidr_blocks[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.computed_ingress_with_cidr_blocks[count.index], "protocol", element(var.rules[lookup(var.computed_ingress_with_cidr_blocks[count.index], "rule", "_")], 2))}"
}

resource "aws_security_group_rule" "computed_ingress_with_source_security_group_id" {
  count = "${var.create ? var.number_of_computed_ingress_with_source_security_group_id : 0}"

  security_group_id = "${aws_security_group.odmont.id}"
  type              = "ingress"

  source_security_group_id = "${lookup(var.computed_ingress_with_source_security_group_id[count.index], "source_security_group_id")}"
  description              = "${lookup(var.computed_ingress_with_source_security_group_id[count.index], "description", "Ingress Rule")}"

  from_port = "${lookup(var.computed_ingress_with_source_security_group_id[count.index], "from_port", element(var.rules[lookup(var.computed_ingress_with_source_security_group_id[count.index], "rule", "_")], 0))}"
  to_port   = "${lookup(var.computed_ingress_with_source_security_group_id[count.index], "to_port", element(var.rules[lookup(var.computed_ingress_with_source_security_group_id[count.index], "rule", "_")], 1))}"
  protocol  = "${lookup(var.computed_ingress_with_source_security_group_id[count.index], "protocol", element(var.rules[lookup(var.computed_ingress_with_source_security_group_id[count.index], "rule", "_")], 2))}"
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  security_group_id = "${aws_security_group.odmont.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}
