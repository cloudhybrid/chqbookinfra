variable "region" {
  description = "Region for launching subnets"
  default     = "us-east-1"
}

variable "profile" {
  description = "Aws Profiles for Infra"
  default     = "timesinternet"
}

variable "vpc_cidr" {
    description = "CIDR of the VPC" 
    default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "prod_vpc"
}

variable "route53_zone_name" {
  description = "Route53 record zone name"
  default     = "internal-timesprime.com"
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
  default     = "10.0.0.0/20"
}

variable "pub_sub_a_name" {
  description = "Name of the public subnet of aza"
  default     = "prod_pub_sub_aza"
}

variable "pub_sub_b_cidr" {
  description = "CIDR block for the public subnet of azb"
  default     = "10.0.16.0/20"
}

variable "pub_sub_b_name" {
  description = "Name of the public subnet of azb"
  default     = "prod_pub_sub_azb"
}

variable "priv_app_sub_a_cidr" {
  description = "CIDR block of the private subnet for application AZA"
  default     = "10.0.32.0/20"
}

variable "priv_app_sub_a_name" {
  description = "Name of the private subnet for application AZA"
  default     = "prod_app_priv_sub_aza"
}

variable "priv_app_sub_b_cidr" {
  description = "CIDR block of the private subnet for application AZB"
  default     = "10.0.48.0/20"
}

variable "priv_app_sub_b_name" {
  description = "Name of the private subnet for application AZB"
  default     = "prod_app_priv_sub_azb"
}

variable "priv_db_sub_a_cidr" {
  description = "CIDR block of the private subnet for db AZA"
  default     = "10.0.64.0/20"
}

variable "priv_db_sub_a_name" {
  description = "Name of the private subnet of db AZA"
  default     = "prod_db_priv_sub_aza"
}

variable "priv_db_sub_b_cidr" {
  description = "CIDR block of the private subnet for db AZB"
  default     = "10.0.80.0/20"
}

variable "priv_db_sub_b_name" {
  description = "Name of the private subnet of db AZB"
  default     = "prod_db_priv_sub_azb"
}

variable "priv_middleware_sub_a_cidr" {
  description = "CIDR block of the protected subnet for middleware AZA"
  default     = "10.0.96.0/20"
}

variable "priv_middleware_sub_a_name" {
  description = "Name of the protected subnet of middleware AZA"
  default     = "prod_mid_priv_sub_aza"
}

variable "priv_middleware_sub_b_cidr" {
  description = "CIDR block of the protected subnet for middleware AZB"
  default     = "10.0.112.0/20"
}

variable "priv_middleware_sub_b_name" {
  description = "Name of the protected subnet of middleware AZB"
  default     = "prod_mid_priv_sub_azb"
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  default     = "prod_public_route_table"
}

variable "private_route_table_name" {
  description = "Name of the private route table"
  default     = "prod_private_route_table"
}
