resource "aws_route53_record" "route53_record" {
  zone_id = "${var.zone_id}"
  name    = "${var.name}"
  type    = "A"
  ttl     = "30"
  records = ["${var.instance_private_ip}"]
}
