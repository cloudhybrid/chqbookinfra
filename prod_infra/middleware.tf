module "es_master_1" {
    source                      = "../modules/ec2"
    name                        = "${var.es1_master_name}"
    instance_type               = "${var.es_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_aza_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.es_ami_id}"
    root_volume_type            = "${var.es_root_volume_type}"
    root_volume_size            = "${var.es_root_volume_size}"
    security_group_ids          = ["${aws_security_group.prod_es_security_group.id}"]
}

module "es_master_2" {
    source                      = "../modules/ec2"
    name                        = "${var.es2_master_name}"
    instance_type               = "${var.es_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_aza_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.es_ami_id}"
    root_volume_type            = "${var.es_root_volume_type}"
    root_volume_size            = "${var.es_root_volume_size}"
    security_group_ids          = ["${aws_security_group.prod_es_security_group.id}"]
}

module "es_master_3" {
    source                      = "../modules/ec2"
    name                        = "${var.es3_master_name}"
    instance_type               = "${var.es_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_azb_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.es_ami_id}"
    root_volume_type            = "${var.es_root_volume_type}"
    root_volume_size            = "${var.es_root_volume_size}"
    security_group_ids          = ["${aws_security_group.prod_es_security_group.id}"]
}

module "mongo_master" {
    source                      = "../modules/ec2"
    name                        = "${var.mongo_master_name}"
    instance_type               = "${var.mongo_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_aza_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.mongo_ami_id}"
    root_volume_type            = "${var.mongo_root_volume_type}"
    root_volume_size            = "${var.mongo_root_volume_size}"
    security_group_ids          = ["${aws_security_group.prod_mongo_security_group.id}"]
}

module "mongo_arbiter" {
    source                      = "../modules/ec2"
    name                        = "${var.mongo_arbiter_name}"
    instance_type               = "${var.mongo_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_aza_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.mongo_ami_id}"
    root_volume_type            = "${var.mongo_root_volume_type}"
    root_volume_size            = "${var.mongo_root_volume_size}"
    security_group_ids          = ["${aws_security_group.prod_mongo_security_group.id}"]
}

module "mongo_slave" {
    source                      = "../modules/ec2"
    name                        = "${var.mongo_slave_name}"
    instance_type               = "${var.mongo_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_azb_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.mongo_ami_id}"
    root_volume_type            = "${var.mongo_root_volume_type}"
    root_volume_size            = "${var.mongo_root_volume_size}"
    security_group_ids          = ["${aws_security_group.prod_mongo_security_group.id}"]
}

module "kafka_server_1" {
    source                      = "../modules/ec2"
    name                        = "${var.kafka_server_1_name}"
    instance_type               = "${var.kafka_server_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_aza_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.kafka_server_ami_id}"
    root_volume_type            = "${var.kafka_server_root_volume_type}"
    root_volume_size            = "${var.kafka_server_root_volume_size}"
    security_group_ids          = ["${aws_security_group.kafka_sg.id}"]
}

module "kafka_server_2" {
    source                      = "../modules/ec2"
    name                        = "${var.kafka_server_2_name}"
    instance_type               = "${var.kafka_server_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_aza_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.kafka_server_ami_id}"
    root_volume_type            = "${var.kafka_server_root_volume_type}"
    root_volume_size            = "${var.kafka_server_root_volume_size}"
    security_group_ids          = ["${aws_security_group.kafka_sg.id}"]
}

module "kafka_server_3" {
    source                      = "../modules/ec2"
    name                        = "${var.kafka_server_3_name}"
    instance_type               = "${var.kafka_server_instance_type}"
    subnet_id                   = "${data.terraform_remote_state.timesprime-infra_prod_infra.private_middleware_sub_azb_id}"
    number_of_instances         = "${var.number_of_instances}"
    key_name                    = "${var.prod_key_pair_name}"
    associate_public_ip_address = "false"
    user_data                   = ""
    ami_id                      = "${var.kafka_server_ami_id}"
    root_volume_type            = "${var.kafka_server_root_volume_type}"
    root_volume_size            = "${var.kafka_server_root_volume_size}"
    security_group_ids          = ["${aws_security_group.kafka_sg.id}"]
}
