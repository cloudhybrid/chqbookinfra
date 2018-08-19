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
