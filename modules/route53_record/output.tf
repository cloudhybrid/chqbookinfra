output "route53_name" {
  description = "Name of your route53 record"
  value = "${aws_route53_record.route53_record.name}"
}
