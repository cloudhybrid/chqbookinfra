variable "zone_id" {
    description = "Zone ID in which you want to create route53 record"
}

variable "name" {
  description = "Name of the instance that you want in route53 with domain name for example:- test.example.com"
}

variable "instance_private_ip" {
  type        = "list"
  description = "EC2 instance private IP with you want to associate your route53 record"
}

