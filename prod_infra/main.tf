provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "vpc" {
    source               = "../modules/vpc"
    cidr                 = "${var.vpc_cidr}"
    name                 = "${var.vpc_name}"
    route53_zone_name    = "${var.route53_zone_name}"
    enable_dns_hostnames = "${var.enable_dns_hostnames}"
    enable_dns_support   = "${var.enable_dns_support}"
}

module "nat_gateway" {
  source                  = "../modules/nat-gateway"
  subnet_id               = "${module.pub_sub_b.id}"
}

module "pub_sub_a" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.pub_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.pub_sub_a_name}"
    map_public_ip_on_launch = "false"
}

module "pub_sub_b" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.pub_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.pub_sub_b_name}"
    map_public_ip_on_launch = "false"
}

module "priv_app_sub_a" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_app_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.priv_app_sub_a_name}"
    map_public_ip_on_launch = "false"
}

module "priv_app_sub_b" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_app_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.priv_app_sub_b_name}"
    map_public_ip_on_launch = "false"
}
module "priv_db_sub_a" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_db_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.priv_db_sub_a_name}"
    map_public_ip_on_launch = "false"
}

module "priv_db_sub_b" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_db_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.priv_db_sub_b_name}"
    map_public_ip_on_launch = "false"
}

module "priv_middleware_sub_a" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_middleware_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.priv_middleware_sub_a_name}"
    map_public_ip_on_launch = "false"
}

module "priv_middleware_sub_b" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_middleware_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.priv_middleware_sub_b_name}"
    map_public_ip_on_launch = "false"
}

module "public_route_table" {
  source                   = "../modules/route_table"
  vpc_id                   = "${module.vpc.id}"
  gateway_id               = "${module.vpc.internet_gateway_id}"
  route_table_name         = "${var.public_route_table_name}"
}

module "private_route_table" {
  source                   = "../modules/route_table"
  vpc_id                   = "${module.vpc.id}"
  gateway_id               = "${module.nat_gateway.nat_gateway_id}"
  route_table_name         = "${var.private_route_table_name}"
}

module "prod_pub_sn_a_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.pub_sub_a.id}"
  route_table_id   = "${module.public_route_table.route_table_id}"
}

module "prod_pub_sn_b_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.pub_sub_b.id}"
  route_table_id   = "${module.public_route_table.route_table_id}"
}

module "priv_app_sn_a_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.priv_app_sub_a.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}

module "priv_app_sn_b_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.priv_app_sub_b.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}

module "priv_middleware_sn_a_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.priv_middleware_sub_a.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}

module "priv_middleware_sn_b_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.priv_middleware_sub_a.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}

module "bastion_instance" {
    source                      = "../modules/ec2"
    name                        = "${var.bastion_server_name}"
    instance_type               = "${var.bastion_instance_type}"
    subnet_id                   = "${module.pub_sub_a.id}"
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
  instance_subnets      = ["${module.priv_app_sub_a.id}", "${module.priv_app_sub_b.id}"]
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
  instance_subnets      = ["${module.priv_app_sub_a.id}", "${module.priv_app_sub_b.id}"]
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
  instance_subnets      = ["${module.priv_app_sub_a.id}", "${module.priv_app_sub_b.id}"]
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
  instance_subnets      = ["${module.priv_app_sub_a.id}", "${module.priv_app_sub_b.id}"]
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
