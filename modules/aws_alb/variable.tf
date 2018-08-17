variable "name" {}

variable "env" {}

variable "project" {}

variable "purpose" {}

variable "internal" {
  default = "false"
}

variable "security_group_ids" {
  type = "list"
}

variable "alb_subnets" {
  type = "list"
}

variable "enable_deletion_protection" {
  default = "false"
}
