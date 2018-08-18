variable "name" {}

variable "asg_max" {
  default = "1"
}

variable "asg_min" {
  default = "1"
}

variable "asg_desired" {
  default = "1"
}


variable "instance_subnets" {
  default = []
}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = ""
}


variable "security_group_ids" {
  type = "list"
}


variable "user_data" {
  default = ""
}


variable "iam_instance_profile" {
  default = ""
}

variable "suspended_processes" {
  default = []
}

variable "asg_root_volume_type" {
  default = "gp2"
}

variable "asg_root_volume_size" {
  default = "10"
}

variable "target_group_arns" {
  default = ""
}

variable "group" {
default = ""
}
variable "team" {
default = ""
}
variable "project" {
default = ""
}
variable "environment" {
default = ""
}
variable "owner" {
default = ""
}
variable "use" {
default = ""
}
variable "env" {
default = ""
}
variable "class" {
default = ""
}
variable "purpose" {
default = ""
}
