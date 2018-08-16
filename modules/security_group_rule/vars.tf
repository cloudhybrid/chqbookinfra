variable "type" {
  description = "Type of the role ingress or egress"
  default = "ingress"
}

variable "to_port" {
  description = "Port no. for which traffic allowing"
}

variable "from_port" {
  description = "Port no. from which traffic allowing"
}

variable "protocol" {
  description = "For which protocol you want to allow"
  default = "all"
}

variable "cidr_block" {
  description = "From which CIDR block traffic should be allowed"
  default = "0.0.0.0/0"
}

variable "security_group_id" {
  description = "For which security group you want to create rule"
}
