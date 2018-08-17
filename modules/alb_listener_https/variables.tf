
variable "load_balancer_arn" {
  description = "ARN number of load balancer"
}

variable "port" {
  default = "443"
}

variable "protocol" {
  default = "HTTPS"
}

variable "target_group_arn" {
  description = "TG ARN"
}

variable "certificate_arn" {
  description =  "ARN of ssl certificate"
}

variable "security_policy" {
  description =  "Security Policy of Certificate"
}
