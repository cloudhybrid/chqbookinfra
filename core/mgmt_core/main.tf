provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

module "vpc" {
    source               = "../../modules/vpc"
    cidr                 = "${var.vpc_cidr}"
    name                 = "${var.vpc_name}"
    route53_zone_name    = "${var.route53_zone_name}"
    enable_dns_hostnames = "${var.enable_dns_hostnames}"
    enable_dns_support   = "${var.enable_dns_support}"
}

module "pub_sub_a" {
    source                  = "../../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.pub_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.pub_sub_a_name}"
    map_public_ip_on_launch = "false"
}

module "pub_sub_b" {
    source                  = "../../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.pub_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.pub_sub_b_name}"
    map_public_ip_on_launch = "false"
}

module "priv_sub_a" {
    source                  = "../../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.priv_sub_a_name}"
    map_public_ip_on_launch = "false"
}

module "priv_sub_b" {
    source                  = "../../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.priv_sub_b_name}"
    map_public_ip_on_launch = "false"
}

module "nat_gateway" {
  source                  = "../../modules/nat-gateway"
  subnet_id               = "${module.pub_sub_b.id}"
}

module "public_route_table" {
  source                   = "../../modules/route_table"
  vpc_id                   = "${module.vpc.id}"
  gateway_id               = "${module.vpc.internet_gateway_id}"
  route_table_name         = "${var.public_route_table_name}"
}

module "private_route_table" {
  source                   = "../../modules/route_table"
  vpc_id                   = "${module.vpc.id}"
  gateway_id               = "${module.nat_gateway.nat_gateway_id}"
  route_table_name         = "${var.private_route_table_name}"
}

module "pub_sn_a_association" {
  source           = "../../modules/subnet_association"
  subnet_id        = "${module.pub_sub_a.id}"
  route_table_id   = "${module.public_route_table.route_table_id}"
}

module "pub_sn_b_association" {
  source           = "../../modules/subnet_association"
  subnet_id        = "${module.pub_sub_b.id}"
  route_table_id   = "${module.public_route_table.route_table_id}"
}

module "priv_sn_a_association" {
  source           = "../../modules/subnet_association"
  subnet_id        = "${module.priv_sub_a.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}

module "priv_sn_b_association" {
  source           = "../../modules/subnet_association"
  subnet_id        = "${module.priv_sub_b.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}
