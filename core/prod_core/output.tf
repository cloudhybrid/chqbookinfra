output "vpc_id" {
  description = "Ouput ID of the created VPC"
  value = "${module.vpc.id}"
}

output "default_sg_id" {
  value = "${module.vpc.default_sg_id}"
}

output "route53_zone_id" {
  description = "Ouput ID of the created Route53 zone"
  value = "${module.vpc.zone_id}"
}

output "public_subnet_a_id" {
  description = "Ouput ID of the created Public Subnet AZA"
  value = "${module.pub_sub_a.id}"
}

output "public_subnet_b_id" {
  description = "Ouput ID of the created Public Subnet AZB"
  value = "${module.pub_sub_b.id}"
}

output "nat_gateway_id" {
  description = "Output ID of the nat gateway of vpc"
  value = "${module.nat_gateway.nat_gateway_id}"
}

output "private_app_sub_aza_id" {
  description = "Output ID of the private app subnet aza"
  value = "${module.priv_app_sub_a.id}"
}

output "private_app_sub_azb_id" {
  description = "Output ID of the private app subnet azb"
  value = "${module.priv_app_sub_b.id}"
}

output "private_db_sub_aza_id" {
  description = "Output ID of the private db subnet aza"
  value = "${module.priv_db_sub_a.id}"
}

output "private_db_sub_azb_id" {
  description = "Output ID of the private db subnet azb"
  value = "${module.priv_db_sub_b.id}"
}

output "private_middleware_sub_aza_id" {
  description = "Output ID of the private middleware subnet aza"
  value = "${module.priv_middleware_sub_a.id}"
}

output "private_middleware_sub_azb_id" {
  description = "Output ID of the private middleware subnet azb"
  value = "${module.priv_middleware_sub_b.id}"
}

output "private_route_table_id" {
  description = "Ouput ID of the created Private Route Table"
  value = "${module.private_route_table.route_table_id}"
}

output "public_route_table_id" {
  description = "Ouput ID of the created Private Route Table"
  value = "${module.public_route_table.route_table_id}"
}
