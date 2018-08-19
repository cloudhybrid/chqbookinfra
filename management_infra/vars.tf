variable "region" {
  description = "Region for launching subnets"
  default     = "us-east-1"
}

variable "profile" {
  description = "Aws Profiles for Infra"
  default     = "timesinternet"
}

variable "route53_zone_name" {
  description = "Route53 record zone name"
  default     = "internal.management.com"
}

variable "key_pair_name" {
  description = "Name of the key pair"
  default     = "management_key"
}

variable "public_key_path" {
  description = "Path of the key on your local machine"
  default     = "~/.ssh/id_rsa.pub"
}

variable "bastion_secuirty_group_name" {
  description = "Name of the Bastion Security Group"
  default     = "bastion_sg"
}


variable "alb_secuirty_group_name" {
  description = "Name of the Management ALB Security Group"
  default     = "mgmt_alb_sg"
}

variable "jenkins_secuirty_group_name" {
  description = "Name of the Jenkins Security Group"
  default     = "jenkins_sg"
}

variable "bastion_server_name" {
  description = "Name of the bastion server name"
  default     = "management_bastion"
}

variable "bastion_instance_type" {
  description = "Instance type of the bastion server"
  default     = "t2.micro"
}

variable "bastion_ami_id" {
  description = "AMI Id for the Bastion Server"
  default     = "ami-b70554c8"
}

variable "number_of_instances" {
  description = "Number of instance you want to launch"
  default     = "1"
}

variable "root_volume_type" {
  description = "Type of the root volume"
  default     = "gp2"
}

variable "root_volume_size" {
  description = "Volume size of the root partition"
  default     = "20"
}

# variable "jenkins_key_path" {
#   description = "Key path for Jenkins Key"
#   default     = "~/.ssh/jenkins.pub"
# }

variable "jenkins_key_pair_name" {
  description = "Name of the jenkins key"
  default     = "jenkins_key"
}

variable "jenkins_server_name" {
  description = "Name of the jenkins server"
  default     = "jenkins_server"
}

variable "jenkins_instance_type" {
  description = "Type of the jenkins Instance"
  default     = "t2.medium"
}

variable "jenkins_ami_id" {
  description = "AMI ID for the Jenkins Server"
  default     = "ami-b70554c8"
}
variable "jenkins_header" {
  description = "jenkins subdomain to be opened from public end"
  default     = "jenkins.timesinternet.com"
}
