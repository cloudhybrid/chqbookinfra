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

output "private_subnet_a_id" {
  description = "Ouput ID of the created Private Subnet AZA"
  value = "${module.priv_sub_a.id}"
}

output "private_subnet_b_id" {
  description = "Ouput ID of the created Private Subnet AZB"
  value = "${module.priv_sub_b.id}"
}

output "private_route_table_id" {
  description = "Ouput ID of the created Private Route Table"
  value = "${module.private_route_table.route_table_id}"
}

output "public_route_table_id" {
  description = "Ouput ID of the created Private Route Table"
  value = "${module.public_route_table.route_table_id}"
}
