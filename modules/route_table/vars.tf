variable "route_table_name" {
  description = "Name of your private route table"
}

variable "vpc_id" {
  description = "VPC id in which you want to create route table"
}

variable "gateway_id" {
  description = "Nat Gateway ID in which should be associated to this Route Table"
}
