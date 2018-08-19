provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "bastion_instance" {
    source                      = "../modules/ec2"
    name                        = "${var.bastion_server_name}"
    instance_type               = "${var.bastion_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.public_subnet_a_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "true"
    user_data                   = ""
    ami_id                      = "${var.bastion_ami_id}"
    root_volume_type            = "${var.root_volume_type}"
    root_volume_size            = "${var.root_volume_size}"
    security_group_ids          = ["${module.bastion_security_group.id}"]
}

module "prod_communication_asg" {
  source                = "../modules/autoscaling_group"
  name                  = "asg_prod_communication"
  instance_subnets      = ["${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_aza_id}", "${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_azb_id}"]
  asg_max               = "${var.comm_asg_max}"
  asg_min               = "${var.comm_asg_min}"
  asg_desired           = "${var.comm_asg_desired}"
  ami_id                = "${var.comm_asg_ami_id}"
  instance_type         = "${var.communication_instance_type}"
  security_group_ids    = ["${aws_security_group.communication_security_group.id}"]
#   user_data             = ""
  asg_root_volume_size  = "${var.root_volume_size_asg}"
  target_group_arns     = "${module.communication_tg.arn}"
  env                   =  "prod"
  project               =  "prod_communication"
}

module "prod_pwa_asg" {
  source                = "../modules/autoscaling_group"
  name                  = "asg_prod_pwa"
  instance_subnets      = ["${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_aza_id}", "${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_azb_id}"]
  asg_max               = "${var.pwa_asg_max}"
  asg_min               = "${var.pwa_asg_min}"
  asg_desired           = "${var.pwa_asg_desired}"
  ami_id                = "${var.pwa_asg_ami_id}"
  instance_type         = "${var.pwa_instance_type}"
  security_group_ids    = ["${aws_security_group.prod_pwa_security_group.id}"]
#   user_data             = ""
  asg_root_volume_size  = "${var.root_volume_size_asg}"
  target_group_arns     = "${module.pwa_tg.arn}"
  env                   =  "prod"
  project               =  "prod_pwa"
}

module "prod_subscription_asg" {
  source                = "../modules/autoscaling_group"
  name                  = "asg_prod_subscription"
  instance_subnets      = ["${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_aza_id}", "${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_azb_id}"]
  asg_max               = "${var.sub_asg_max}"
  asg_min               = "${var.sub_asg_min}"
  asg_desired           = "${var.sub_asg_desired}"
  ami_id                = "${var.sub_asg_ami_id}"
  instance_type         = "${var.subscription_instance_type}"
  security_group_ids    = ["${aws_security_group.prod_subscription_security_group.id}"]
#   user_data             = ""
  asg_root_volume_size  = "${var.root_volume_size_asg}"
  target_group_arns     = "${module.subscription_tg.arn}"
  env                   =  "prod"
  project               =  "prod_subscription"
}

module "prod_timesprime_asg" {
  source                = "../modules/autoscaling_group"
  name                  = "asg_prod_timesprime"
  instance_subnets      = ["${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_aza_id}", "${data.terraform_remote_state.timesprime-infra_prod_infra.private_app_sub_azb_id}"]
  asg_max               = "${var.times_asg_max}"
  asg_min               = "${var.times_asg_min}"
  asg_desired           = "${var.times_asg_desired}"
  ami_id                = "${var.times_asg_ami_id}"
  instance_type         = "${var.timesprime_instance_type}"
  security_group_ids    = ["${aws_security_group.prod_timesprime_security_group.id}"]
#   user_data             = ""
  asg_root_volume_size  = "${var.root_volume_size_asg}"
  target_group_arns     = "${module.subscription_tg.arn}"
  env                   =  "prod"
  project               =  "prod_timesprime"
}
