
variable "load_balancer_arn" {
  description = "ARN number of load balancer"
}

variable "port" {
  default = "80"
}

variable "protocol" {
  default = "HTTP"
}

variable "target_group_arn" {
  description = "TG ARN"
}

