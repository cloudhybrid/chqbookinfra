module "vpc_peering" {
  source                    = "../modules/vpc_peering"
  peer_vpc_id               = "vpc-123abc"
  source_vpc_id             = "vpc-xyz987"
  auto_accept               = "true"
  peer_vpc_route_table_id   = "rtb-abc123"
  source_vpc_cidr           = "172.31.0.0/16"
  source_vpc_route_table_id = "rtb-xyz987"
  peer_vpc_cidr             = "10.10.0.0/16"
  source_vpc_sg_id          = "sg-abc123"
  peered_vpc_sg_id          = "sg-xyz987"
}
