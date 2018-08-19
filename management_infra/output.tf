output "bastion_security_group_id" {
  description = "Ouput ID of the created Security Group"
  value = "${module.bastion_secuirty_group.id}"
}

output "bastion_server_private_ip" {
  description = "Ouput private IP of the created bastion's server"
  value = "${module.bastion_instance.private_ip}"
}

output "bastion_server_public_ip" {
  description = "Ouput public IP of the created bastion's server"
  value = "${module.bastion_instance.public_ip}"
}

output "jenkins_secuirty_group_id" {
  description = "Output ID of the Jenkins Security Group"
  value       = "${aws_security_group.jenkins_secuirty_group.id}"
}

output "jenkins_iam_role_name" {
  value = "${aws_iam_role.iam_role.name}"
}

output "jenkins_profile_id" {
  value = "${aws_iam_instance_profile.jenkins_profile.id}"
}

output "jenkins_profile_arn" {
  value = "${aws_iam_instance_profile.jenkins_profile.arn}"
}

output "jenkins_server_private_ip" {
  description = "Ouput private IP of the created bastion's server"
  value = "${module.jenkins_instance.private_ip}"
}

output "jenkins_url" {
  description = "Url of jenkins Server"
  value = "${module.management_alb.alb_dns_name}"
}
