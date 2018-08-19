output "bastion_server_private_ip" {
  description = "Ouput private IP of the created bastion's server"
  value = "${module.bastion_instance.private_ip}"
}

output "bastion_server_public_ip" {
  description = "Ouput public IP of the created bastion's server"
  value = "${module.bastion_instance.public_ip}"
}

output "prod_pwa_asg_id" {
  description = "Output ID of the asg of PWA"
  value = "${module.prod_pwa_asg.id}"
}

output "prod_pwa_asg_arn" {
  description = "Output ID of the arn of PWA"
  value = "${module.prod_pwa_asg.arn}"
}

output "prod_pwa_asg_target_group_arn" {
  description = "Output ID of the target_arn of PWA"
  value = "${module.prod_pwa_asg.arn}"
}

output "prod_pwa_asg_lc_id" {
  description = "Output ID of the lc id of PWA"
  value = "${module.prod_pwa_asg.lc_id}"
}

output "prod_subscription_asg_id" {
  description = "Output ID of the asg of Subscription"
  value = "${module.prod_subscription_asg.id}"
}

output "prod_subscription_asg_arn" {
  description = "Output ID of the arn of Subscription"
  value = "${module.prod_subscription_asg.arn}"
}

output "prod_subscription_asg_target_group_arn" {
  description = "Output ID of the target_arn of Subscription"
  value = "${module.prod_subscription_asg.arn}"
}

output "prod_subscription_asg_lc_id" {
  description = "Output ID of the lc id of Subscription"
  value = "${module.prod_subscription_asg.lc_id}"
}

output "prod_communication_asg_id" {
  description = "Output ID of the asg of Communication"
  value = "${module.prod_communication_asg.id}"
}

output "prod_communication_asg_arn" {
  description = "Output ID of the arn of Communication"
  value = "${module.prod_communication_asg.arn}"
}

output "prod_communication_asg_target_group_arn" {
  description = "Output ID of the target_arn of Communication"
  value = "${module.prod_communication_asg.arn}"
}

output "prod_communication_asg_lc_id" {
  description = "Output ID of the lc id of Communication"
  value = "${module.prod_communication_asg.lc_id}"
}

output "prod_timesprime_asg_id" {
  description = "Output ID of the asg of Timesprime"
  value = "${module.prod_timesprime_asg.id}"
}

output "prod_timesprime_asg_arn" {
  description = "Output ID of the arn of Timesprime"
  value = "${module.prod_timesprime_asg.arn}"
}

output "prod_timesprime_asg_target_group_arn" {
  description = "Output ID of the target_arn of Timesprime"
  value = "${module.prod_timesprime_asg.arn}"
}

output "prod_timesprime_asg_lc_id" {
  description = "Output ID of the lc id of Timesprime"
  value = "${module.prod_timesprime_asg.lc_id}"
}

output "external_alb_url" {
  description = "Url of external ALB"
  value = "${module.external_alb.alb_dns_name}"
}

output "internal_alb_url" {
  description = "Url of internal ALB"
  value = "${module.internal_alb.alb_dns_name}"
}

output "bastion_security_group_id" {
  description = "Ouput ID of the Bastion Security Group"
  value = "${module.bastion_security_group.id}"
}

output "kafka_security_group_id" {
  description = "Ouput ID of the kafka Security Group"
  value = "${aws_security_group.kafka_sg.id}"
}

output "external_alb_security_group_id" {
  description = "Ouput ID of the External-ALB Security Group"
  value = "${module.external_alb_sg.id}"
}

output "internal_alb_security_group_id" {
  description = "Ouput ID of the Internal-ALB Security Group"
  value = "${module.internal_alb_sg.id}"
}

output "communication_security_group_id" {
  description = "Ouput ID of the Communication Security Group"
  value = "${aws_security_group.communication_security_group.id}"
}

output "pwa_security_group_id" {
  description = "Ouput ID of the PWA Security Group"
  value = "${aws_security_group.prod_pwa_security_group.id}"
}

output "subscription_security_group_id" {
  description = "Ouput ID of the Subscription Security Group"
  value = "${aws_security_group.prod_subscription_security_group.id}"
}

output "timesprime_security_group_id" {
  description = "Ouput ID of the Timesprime Security Group"
  value = "${aws_security_group.prod_timesprime_security_group.id}"
}

output "es_security_group_id" {
  description = "Ouput ID of the ES Security Group"
  value = "${aws_security_group.prod_es_security_group.id}"
}

output "mongo_security_group_id" {
  description = "Ouput ID of the Mongo Security Group"
  value = "${aws_security_group.prod_mongo_security_group.id}"
}

output "redis_security_group_id" {
  description = "Ouput ID of the Redis Security Group"
  value = "${aws_security_group.prod_redis_security_group.id}"
}

output "communication_db_security_group_id" {
  description = "Ouput ID of the Communication-DB Security Group"
  value = "${aws_security_group.prod_communication_db_security_group.id}"
}

output "timesprime_db_security_group_id" {
  description = "Ouput ID of the Timesprime-DB Security Group"
  value = "${aws_security_group.prod_timesprime_db_security_group.id}"
}

output "subscription_db_security_group_id" {
  description = "Ouput ID of the Subscription-DB Security Group"
  value = "${aws_security_group.prod_subscription_db_security_group.id}"
}

