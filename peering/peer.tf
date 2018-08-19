module "vpc_peering" {
  source                    = "../modules/vpc_peering"
  peer_vpc_id               = "${data.terraform_remote_state.timesprime-infra_management_infra.vpc_id}"
  source_vpc_id             = "${data.terraform_remote_state.timesprime-infra_prod_infra.vpc_id}"
  auto_accept               = "true"
  peer_vpc_route_table_id   = "${data.terraform_remote_state.timesprime-infra_management_infra.public_route_table_id}"
  source_vpc_cidr           = "10.0.0.0/16"
  source_vpc_route_table_id = "${data.terraform_remote_state.timesprime-infra_prod_infra.public_route_table_id}"
  peer_vpc_cidr             = "10.10.0.0/16"
}
