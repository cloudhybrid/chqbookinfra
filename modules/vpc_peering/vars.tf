variable "peer_vpc_id" {
  description = "VPC ID of the requestor"
}

variable "source_vpc_id" {
  description = "VPC ID of the source VPC"
}

variable "auto_accept" {
  description = "Auto acception is enable or not. It will only work in same aws account"
}

variable "peer_vpc_route_table_id" {
  description = "Route table ID of the requestor VPC"
}

variable "source_vpc_cidr" {
  description = "VPC CIDR of the source vpc"
}

variable "source_vpc_route_table_id" {
  description = "Route table ID of the source VPC"
}

variable "peer_vpc_cidr" {
  description = "CIDR block of the peer VPC"
}

variable "source_vpc_sg_id" {
  description = "Security Group ID of the source VPC"
}

variable "peered_vpc_sg_id" {
  description = "Security Group ID of the source VPC"
}
