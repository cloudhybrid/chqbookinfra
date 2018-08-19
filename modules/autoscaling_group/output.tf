output "id" {
  value = "${aws_autoscaling_group.asg.id}"
}

output "arn" {
  value = "${aws_autoscaling_group.asg.arn}"
}

output "target_group_arns" {
  value = "${aws_autoscaling_group.asg.target_group_arns}"
}

output "lc_id" {
  value = "${aws_launch_configuration.lc.id}"
}
