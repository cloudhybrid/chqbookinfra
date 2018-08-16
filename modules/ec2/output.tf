output "public_ip" {
  description = "Public IP of ec2 instance"
  value = "${aws_instance.instance.*.public_ip}"
}


output "id" {
  description = "Instance ID of ec2 instance"
  value = "${aws_instance.instance.*.id}"
}

output "private_ip" {
  description = "Private IP of ec2 instance"
  value = "${aws_instance.instance.*.private_ip}"
}
