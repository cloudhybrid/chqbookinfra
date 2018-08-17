output "vpc_id" {
  description = "Ouput ID of the created VPC"
  value = "${module.vpc.id}"
}

output "route53_zone_id" {
  description = "Ouput ID of the created Route53 zone"
  value = "${module.vpc.zone_id}"
}

output "public_subnet_a_id" {
  description = "Ouput ID of the created Public Subnet AZA"
  value = "${module.pub_sub_a.id}"
}

output "public_subnet_b_id" {
  description = "Ouput ID of the created Public Subnet AZB"
  value = "${module.pub_sub_b.id}"
}

output "private_subnet_a_id" {
  description = "Ouput ID of the created Private Subnet AZA"
  value = "${module.priv_sub_a.id}"
}

output "private_subnet_b_id" {
  description = "Ouput ID of the created Private Subnet AZB"
  value = "${module.priv_sub_b.id}"
}

output "private_route_table_id" {
  description = "Ouput ID of the created Private Route Table"
  value = "${module.private_route_table.route_table_id}"
}

output "public_route_table_id" {
  description = "Ouput ID of the created Private Route Table"
  value = "${module.public_route_table.route_table_id}"
}

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
