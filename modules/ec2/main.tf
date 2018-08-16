resource "aws_instance" "instance" {
  ami                         = "${var.ami_id}"
  count                       = "${var.number_of_instances}"
  subnet_id                   = "${var.subnet_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  iam_instance_profile        = "${var.iam_instance_profile}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  vpc_security_group_ids      = ["${var.security_group_ids}"]
  user_data                   = "${var.user_data}"

  root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = "true"
  }

  tags {
    Name  = "${var.name}"
    linux = "true"
  }
}
