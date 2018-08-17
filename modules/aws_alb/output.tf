output "arn" {
  value = "${aws_lb.test.arn}"
}

output "alb_dns_name" {
  value = "${aws_lb.test.dns_name}"
}

output "alb_id" {
  value = "${aws_lb.test.id}"
}
