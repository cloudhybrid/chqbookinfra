output "nat_eip" {
  description = "The elastic IP of nat-gateway"
  value = "${aws_eip.nat_eip.id}"
}

output "nat_gateway_id" {
  description = "The ID of nat-gateway"
  value = "${aws_nat_gateway.nat_gateway.id}"
}
