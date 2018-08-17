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

module "priv_sub_a" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_sub_a_cidr}"
    az                      = "${var.region}a"
    name                    = "${var.priv_sub_a_name}"
    map_public_ip_on_launch = "false"
}

module "priv_sub_b" {
    source                  = "../modules/subnet"
    vpc_id                  = "${module.vpc.id}"
    cidr                    = "${var.priv_sub_b_cidr}"
    az                      = "${var.region}b"
    name                    = "${var.priv_sub_b_name}"
    map_public_ip_on_launch = "false"
}

module "nat_gateway" {
  source                  = "../modules/nat-gateway"
  subnet_id               = "${module.pub_sub_b.id}"
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

module "pub_sn_a_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.pub_sub_a.id}"
  route_table_id   = "${module.public_route_table.route_table_id}"
}

module "pub_sn_b_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.pub_sub_b.id}"
  route_table_id   = "${module.public_route_table.route_table_id}"
}

module "priv_sn_a_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.priv_sub_a.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}

module "priv_sn_b_association" {
  source           = "../modules/subnet_association"
  subnet_id        = "${module.priv_sub_b.id}"
  route_table_id   = "${module.private_route_table.route_table_id}"
}

module "key_pair" {
    source          = "../modules/key_pair"
    name            = "${var.key_pair_name}"
    public_key_path = "pubkeys/bastion.pub"
}

module "bastion_secuirty_group" {
  source              = "../modules/security_group"
  vpc_id              = "${module.vpc.id}"
  name                = "${var.bastion_secuirty_group_name}"
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "alb_secuirty_group" {
  source              = "../modules/security_group"
  vpc_id              = "${module.vpc.id}"
  name                = "${var.alb_secuirty_group_name}"
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTPS"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "bastion_instance" {
    source                      = "../modules/ec2"
    name                        = "${var.bastion_server_name}"
    instance_type               = "${var.bastion_instance_type}"
    subnet_id                   = "${module.pub_sub_a.id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.key_pair_name}"
    associate_public_ip_address = "true"
    user_data                   = ""
    ami_id                      = "${var.bastion_ami_id}"
    root_volume_type            = "${var.root_volume_type}"
    root_volume_size            = "${var.root_volume_size}"
    security_group_ids          = ["${module.bastion_secuirty_group.id}"]
}

module "route53_record" {
    source              = "../modules/route53_record"
    zone_id             = "${module.vpc.zone_id}"
    name                = "${var.bastion_server_name}.${var.route53_zone_name}"
    instance_private_ip = ["${module.bastion_instance.private_ip}"]
}

resource "aws_security_group" "jenkins_secuirty_group" {
  name        = "${var.jenkins_secuirty_group_name}"
  vpc_id      = "${module.vpc.id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_secuirty_group.id}"]
  }

    ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${module.alb_secuirty_group.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
    tags {
    Name = "${var.jenkins_secuirty_group_name}"
  }
}

resource "aws_iam_role" "iam_role" {
  name = "jenkins-server-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "vpc-attachment" {
  name       = "vpc-attachment"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_policy_attachment" "ec2-attachment" {
  name       = "ec2-attachment"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "route53-attachment" {
  name       = "route53-attachment"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_policy_attachment" "s3-attachment" {
  name       = "s3-attachment"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins_profile"
  role = "${aws_iam_role.iam_role.name}"
}

module "jenkins_key_pair" {
    source          = "../modules/key_pair"
    name            = "${var.jenkins_key_pair_name}"
    public_key_path = "pubkeys/jenkins.pub"
    
}

data "template_file" "bootstrap_jenkins_master" {
  template = "${file("../user_data/jenkins.tpl")}"
}

module "jenkins_instance" {
    source                      = "../modules/ec2"
    name                        = "${var.jenkins_server_name}"
    instance_type               = "${var.jenkins_instance_type}"
    subnet_id                   = "${module.priv_sub_a.id}"
    number_of_instances         = "${var.number_of_instances}"
    associate_public_ip_address = "false"
    key_name                    = "${var.jenkins_key_pair_name}"
    iam_instance_profile        = "jenkins_profile"
    user_data                   = "${data.template_file.bootstrap_jenkins_master.rendered}"
    ami_id                      = "${var.jenkins_ami_id}"
    root_volume_type            = "${var.root_volume_type}"
    root_volume_size            = "${var.root_volume_size}"
    security_group_ids          = ["${aws_security_group.jenkins_secuirty_group.id}"]
}

module "jenkins_route53_record" {
    source              = "../modules/route53_record"
    zone_id             = "${module.vpc.zone_id}"
    name                = "${var.jenkins_server_name}.${var.route53_zone_name}"
    instance_private_ip = ["${module.jenkins_instance.private_ip}"]
}
