variable "name" {
  description = "Name of the VPC to be created"
}

variable "cidr" {
  description = "CIDR of VPC"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "enable_dns_support" {
  default = "true"
}

variable "route53_zone_name" {
  description = "Name of the route53 zone"
  default     = "internal.test.com"
}
