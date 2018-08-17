module "default-tg" {
  source                = "../modules/targetgroup"
  target_group_name     = "default-tg"
  backend_port          = "80"
  backend_protocol      = "HTTP"
  vpc_id                = "${module.vpc.id}"
  health_check_interval = "10"
  health_check_path     = "/"
  health_check_port     = "traffic-port"
  health_check_timeout  = "5"
  health_check_matcher  = "200-499"
  target_type           = "instance"
}

module "management_alb" {
  source                     = "../modules/aws_alb"
  name                       = "management-alb"
  internal                   = "false"
  security_group_ids         = ["${module.alb_secuirty_group.id}"]
  alb_subnets                = ["${module.pub_sub_a.id}", "${module.pub_sub_b.id}"]
  enable_deletion_protection = "false"
  env                        = "management"
  project                    = "timesprime"
  purpose                    = "top level management elb"
}

module "management_alb_listener" {
  source            = "../modules/alb_listener"
  load_balancer_arn = "${module.management_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  target_group_arn  = "${module.jenkins-tg.arn}"
}

module "jenkins-tg" {
  source                = "../modules/targetgroup"
  target_group_name     = "jenkins-tg"
  backend_port          = "8080"
  backend_protocol      = "HTTP"
  vpc_id                = "${module.vpc.id}"
  health_check_interval = "6"
  health_check_path     = "/"
  health_check_port     = "traffic-port"
  health_check_timeout  = "5"
  health_check_matcher  = "200-499"
  target_type           = "instance"
}


module "jenkins_tg_register" {
  source           = "../modules/targetgroup_attachment"
  target_group_arn = "${module.jenkins-tg.arn}"
  instance_id      = "${module.jenkins_instance.id[0]}"
}

module "management_alb_listener_rule_90" {
  source           = "../modules/alb_listener_rule"
  listener_arn     = "${module.management_alb_listener.arn}"
  priority         = "90"
  target_group_arn = "${module.jenkins-tg.arn}"
  host-header      = "${module.management_alb.alb_dns_name}"
}