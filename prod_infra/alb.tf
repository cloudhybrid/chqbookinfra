module "internal-default-tg" {
  source                = "../modules/targetgroup"
  target_group_name     = "internal-default-tg"
  backend_port          = "8080"
  backend_protocol      = "HTTP"
  vpc_id                = "${module.vpc.id}"
  health_check_interval = "10"
  health_check_path     = "/"
  health_check_port     = "traffic-port"
  health_check_timeout  = "5"
  health_check_matcher  = "200-499"
  target_type           = "instance"
}

module "communication_tg" {
  source                = "../modules/targetgroup"
  target_group_name     = "communication-tg"
  backend_port          = "8080"
  backend_protocol      = "HTTP"
  vpc_id                = "${module.vpc.id}"
  health_check_interval = "10"
  health_check_path     = "/"
  health_check_port     = "traffic-port"
  health_check_timeout  = "5"
  health_check_matcher  = "200-499"
  target_type           = "instance"
}

module "pwa_tg" {
  source                = "../modules/targetgroup"
  target_group_name     = "pwa-tg"
  backend_port          = "8080"
  backend_protocol      = "HTTP"
  vpc_id                = "${module.vpc.id}"
  health_check_interval = "10"
  health_check_path     = "/"
  health_check_port     = "traffic-port"
  health_check_timeout  = "5"
  health_check_matcher  = "200-499"
  target_type           = "instance"
}


module "subscription_tg" {
  source                = "../modules/targetgroup"
  target_group_name     = "subscription-tg"
  backend_port          = "8080"
  backend_protocol      = "HTTP"
  vpc_id                = "${module.vpc.id}"
  health_check_interval = "10"
  health_check_path     = "/"
  health_check_port     = "traffic-port"
  health_check_timeout  = "5"
  health_check_matcher  = "200-499"
  target_type           = "instance"
}

module "timesprime_tg" {
  source                = "../modules/targetgroup"
  target_group_name     = "timesprime-tg"
  backend_port          = "8080"
  backend_protocol      = "HTTP"
  vpc_id                = "${module.vpc.id}"
  health_check_interval = "10"
  health_check_path     = "/"
  health_check_port     = "traffic-port"
  health_check_timeout  = "5"
  health_check_matcher  = "200-499"
  target_type           = "instance"
}

module "external_alb" {
  source                     = "../modules/aws_alb"
  name                       = "external-alb"
  internal                   = "false"
  security_group_ids         = ["${module.external_alb_sg.id}"]
  alb_subnets                = ["${module.pub_sub_a.id}", "${module.pub_sub_b.id}"]
  enable_deletion_protection = "false"
  env                        = "prod"
  project                    = "timesprime"
  purpose                    = "top level prod public alb"
}

module "external_alb_listener" {
  source            = "../modules/alb_listener"
  load_balancer_arn = "${module.external_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  target_group_arn  = "${module.pwa_tg.arn}"
}

module "internal_alb" {
  source                     = "../modules/aws_alb"
  name                       = "pvt-internal-alb"
  internal                   = "true"
  security_group_ids         = ["${module.internal_alb_sg.id}"]
  alb_subnets                = ["${module.priv_app_sub_a.id}", "${module.priv_app_sub_b.id}"]
  enable_deletion_protection = "false"
  env                        = "prod"
  project                    = "timesprime"
  purpose                    = "private alb"
}

module "internal_alb_listener" {
  source            = "../modules/alb_listener"
  load_balancer_arn = "${module.internal_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  target_group_arn  = "${module.internal-default-tg.arn}"
}

module "internal_alb_communication_listener_rule_90" {
  source           = "../modules/alb_listener_rule"
  listener_arn     = "${module.internal_alb_listener.arn}"
  priority         = "90"
  target_group_arn = "${module.communication_tg.arn}"
  host-header      = "comm.${var.route53_zone_name}"
}

module "internal_alb_subscription_listener_rule_100" {
  source           = "../modules/alb_listener_rule"
  listener_arn     = "${module.internal_alb_listener.arn}"
  priority         = "100"
  target_group_arn = "${module.subscription_tg.arn}"
  host-header      = "sub.${var.route53_zone_name}"
}

module "internal_alb_timesprime_listener_rule_110" {
  source           = "../modules/alb_listener_rule"
  listener_arn     = "${module.internal_alb_listener.arn}"
  priority         = "110"
  target_group_arn = "${module.timesprime_tg.arn}"
  host-header      = "timesprime.${var.route53_zone_name}"
}
