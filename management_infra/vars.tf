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
  default     = "t2.micro"
}

variable "jenkins_ami_id" {
  description = "AMI ID for the Jenkins Server"
  default     = "ami-b70554c8"
}
variable "jenkins_header" {
  description = "jenkins subdomain to be opened from public end"
  default     = "jenkins.timesinternet.com"
}
