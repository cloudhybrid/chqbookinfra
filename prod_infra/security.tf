module "kafka_sg" {
  source              = "../modules/security_group"
  vpc_id              = "${module.vpc.id}"
  name                = "prod_kafka_sg"
  ingress_cidr_blocks = ["223.165.28.230/32", "13.127.254.190/32", "13.127.121.231/32", "13.127.240.182/32", "103.18.140.78/32", "103.18.142.24/29", "103.18.142.21/32", "103.18.142.22/32", "103.18.142.23/32"]
  ingress_rules       = ["kafka-rule", "zookeeper-rule"]
}

resource "aws_security_group_rule" "kafka-allow-bastion" {
    type            = "ingress"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_group_id = "${module.bastion_security_group.id}"
}

module "external_alb_sg" {
  source              = "../modules/security_group"
  vpc_id              = "${module.vpc.id}"
  name                = "external_alb_sg"
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
      },  
  ]
}

module "internal_alb_sg" {
  source              = "../modules/security_group"
  vpc_id              = "${module.vpc.id}"
  name                = "internal_alb_sg"
  ingress_with_cidr_blocks = [
      {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          description = "HTTP"
          cidr_blocks = "10.0.0.0/16"
      },
  ]
}

resource "aws_security_group" "communication_security_group" {
  name        = "communication_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${module.internal_alb_sg.id}"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "communication_security_group"
  }
}

resource "aws_security_group" "prod_pwa_security_group" {
  name        = "prod_pwa_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${module.external_alb_sg.id}"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_pwa_security_group"
  }
}

resource "aws_security_group" "prod_subscription_security_group" {
  name        = "prod_subscription_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${module.internal_alb_sg.id}"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_subscription_security_group"
  }
}

resource "aws_security_group" "prod_timesprime_security_group" {
  name        = "prod_subscription_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${module.internal_alb_sg.id}"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_timesprime_security_group"
  }
}

resource "aws_security_group" "prod_es_security_group" {
  name        = "prod_es_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_a_cidr}"
  }

  ingress {
    from_port       = 9300
    to_port         = 9300
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_a_cidr}"
  }

  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_b_cidr}"
  }

  ingress {
    from_port       = 9300
    to_port         = 9300
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_b_cidr}"
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_es_security_group"
  }
}

resource "aws_security_group" "prod_mongo_security_group" {
  name        = "prod_es_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_a_cidr}"
  }

  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_b_cidr}"
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_mongo_security_group"
  }
}

resource "aws_security_group" "prod_redis_security_group" {
  name        = "prod_redis_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_a_cidr}"
  }

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_b_cidr}"
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_redis_security_group"
  }
}

resource "aws_security_group" "prod_communication_db_security_group" {
  name        = "prod_communication_db_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_a_cidr}"
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_b_cidr}"
  }
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_communication_db_security_group"
  }
}

resource "aws_security_group" "prod_timesprime_db_security_group" {
  name        = "prod_timesprime_db_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_a_cidr}"
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_b_cidr}"
  }
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_timesprime_db_security_group"
  }
}

resource "aws_security_group" "prod_subscription_db_security_group" {
  name        = "prod_subscription_db_security_group"
  vpc_id      = "${module.vpc.id}"
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_a_cidr}"
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = "${var.priv_app_sub_b_cidr}"
  }
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${var.jenkins_sg_id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  tags {
    Name = "prod_subscription_db_security_group"
  }
}