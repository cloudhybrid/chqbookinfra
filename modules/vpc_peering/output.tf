output "aws_peering_id" {
  description = "Output id of the aws peering connection"
  value = "${aws_vpc_peering_connection.vpc_peering.id}"
}
