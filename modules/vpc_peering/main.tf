resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id   = "${var.peer_vpc_id}"
  vpc_id        = "${var.source_vpc_id}"
  auto_accept   = "${var.auto_accept}"
}

resource "aws_route" "peer_vpc_route_entry" {
  route_table_id         = "${var.peer_vpc_route_table_id}"
  destination_cidr_block = "${var.source_vpc_cidr}"
  gateway_id             = "${aws_vpc_peering_connection.vpc_peering.id}"
}

resource "aws_route" "source_vpc_route_entry" {
  route_table_id         = "${var.source_vpc_route_table_id}"
  destination_cidr_block = "${var.peer_vpc_cidr}"
  gateway_id             = "${aws_vpc_peering_connection.vpc_peering.id}"
}

module "source_vpc_default_sg_entry" {
  source            = "../security_group_rule"
  cidr_block        = "${var.peer_vpc_cidr}"
  security_group_id = "${var.source_vpc_sg_id}"
  to_port           = "0"
  from_port         = "0"
}

module "peered_vpc_default_sg_entry" {
  source            = "../security_group_rule"
  cidr_block        = "${var.source_vpc_cidr}"
  security_group_id = "${var.peered_vpc_sg_id}"
  to_port           = "0"
  from_port         = "0"
}
