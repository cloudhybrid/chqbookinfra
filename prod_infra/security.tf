####################
#test sg
# resource "aws_security_group" "test_sg" {
#   name        = "allow_all"
#   description = "Allow all inbound traffic"
#   vpc_id      = "${module.vpc.id}"

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     cidr_blocks     = ["0.0.0.0/0"]
#   }
# }

####################


module "bastion_security_group" {
  source              = "../modules/security_group"
  vpc_id              = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  name                = "${var.bastion_security_group_name}"
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

resource "aws_security_group" "kafka_sg" {
  name        = "prod_kafka_sg"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
  ingress {
    from_port       = 9095
    to_port         = 9095
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 9095
    to_port         = 9095
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }
  
  ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 2181
    to_port         = 2181
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_kafka_sg"
  }
}

module "external_alb_sg" {
  source              = "../modules/security_group"
  vpc_id              = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
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
  vpc_id              = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
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
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
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
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "communication_security_group"
  }
}

resource "aws_security_group" "prod_pwa_security_group" {
  name        = "prod_pwa_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
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
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_pwa_security_group"
  }
}

resource "aws_security_group" "prod_subscription_security_group" {
  name        = "prod_subscription_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
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
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_subscription_security_group"
  }
}

resource "aws_security_group" "prod_timesprime_security_group" {
  name        = "prod_timesprime_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
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
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_timesprime_security_group"
  }
}

resource "aws_security_group" "prod_es_security_group" {
  name        = "prod_es_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 9300
    to_port         = 9300
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }

  ingress {
    from_port       = 9300
    to_port         = 9300
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_es_security_group"
  }
}

resource "aws_security_group" "prod_mongo_security_group" {
  name        = "prod_mongo_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 9200
    to_port         = 9200
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_mongo_security_group"
  }
}

resource "aws_security_group" "prod_redis_security_group" {
  name        = "prod_redis_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_redis_security_group"
  }
}

resource "aws_security_group" "prod_communication_db_security_group" {
  name        = "prod_communication_db_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_communication_db_security_group"
  }
}

resource "aws_security_group" "prod_timesprime_db_security_group" {
  name        = "prod_timesprime_db_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_timesprime_db_security_group"
  }
}

resource "aws_security_group" "prod_subscription_db_security_group" {
  name        = "prod_subscription_db_security_group"
  vpc_id      = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_a_cidr}"]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["${var.priv_app_sub_b_cidr}"]
  }
  
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${data.terraform_remote_state.timesprime-infra_management_infra.jenkins_secuirty_group_id}"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${module.bastion_security_group.id}"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "prod_subscription_db_security_group"
  }
}
