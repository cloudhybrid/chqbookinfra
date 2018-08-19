variable "vpc_cidr" {
    description = "CIDR of the VPC" 
    default     = "10.10.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "management_vpc"
}

variable "route53_zone_name" {
  description = "Route53 record zone name"
  default     = "internal.management.com"
}

variable "enable_dns_hostnames" {
  description = "Whether to enable hostname communication or not"
  default     = "true"
}

variable "enable_dns_support" {
  description = "Whether to enable dns support or not for Route53"
  default     = "true"
}

variable "pub_sub_a_cidr" {
  description = "CIDR block for the public subnet of aza"
  default     = "10.10.0.0/20"
}

variable "region" {
  description = "Region for launching subnets"
  default     = "us-east-1"
}

variable "profile" {
  description = "Aws Profiles for Infra"
  default     = "timesinternet"
}

variable "pub_sub_a_name" {
  description = "Name of the public subnet of aza"
  default     = "pub_sub_aza"
}

variable "pub_sub_b_cidr" {
  description = "CIDR block for the public subnet of azb"
  default     = "10.10.16.0/20"
}

variable "pub_sub_b_name" {
  description = "Name of the public subnet of azb"
  default     = "pub_sub_azb"
}

variable "priv_sub_a_cidr" {
  description = "CIDR block for the private subnet of aza"
  default     = "10.10.32.0/20"
}

variable "priv_sub_a_name" {
  description = "Name of the private subnet of aza"
  default     = "pvt_sub_aza"
}

variable "priv_sub_b_cidr" {
  description = "CIDR block for the private subnet of azb"
  default     = "10.10.64.0/20"
}

variable "priv_sub_b_name" {
  description = "Name of the private subnet of azb"
  default     = "pvt_sub_azb"
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  default     = "public_route_table"
}

variable "private_route_table_name" {
  description = "Name of the private route table"
  default     = "private_route_table"
}
