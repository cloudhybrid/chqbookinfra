output "arn" {
  description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
  value = "${aws_alb_target_group.target_group.arn}"
}
