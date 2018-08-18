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

variable "prod_key_pair_name" {
  description = "Name of the key pair"
  default     = "prod_bastion_key"
}

variable "bastion_security_group_name" {
  description = "Name of the Bastion Security Group"
  default     = "bastion_sg"
}

variable "bastion_server_name" {
  description = "Name of the bastion server name"
  default     = "prod_bastion"
}

variable "bastion_instance_type" {
  description = "Instance type of the bastion server"
  default     = "t2.medium"
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
  default     = "40"
}

variable "jenkins_sg_id" {
  description = "ID of the jenkins security group"
  default     = ""
}

variable "comm_asg_max" {
  description = "Desired count for asg max"
  default     = "1"
}

variable "comm_asg_min" {
  description = "Desired count for asg min"
  default     = "1"
}

variable "comm_asg_desired" {
  description = "Desired count for asg desired"
  default     = "1"
}

variable "comm_asg_ami_id" {
  description = "AMI ID of the ASG group"
  default     = "ami-b70554c8"
}

variable "times_asg_max" {
  description = "Desired count for asg max"
  default     = "1"
}

variable "times_asg_min" {
  description = "Desired count for asg min"
  default     = "1"
}

variable "times_asg_desired" {
  description = "Desired count for asg desired"
  default     = "1"
}

variable "times_asg_ami_id" {
  description = "AMI ID of the ASG group"
  default     = "ami-b70554c8"
}

variable "sub_asg_max" {
  description = "Desired count for asg max"
  default     = "1"
}

variable "sub_asg_min" {
  description = "Desired count for asg min"
  default     = "1"
}

variable "sub_asg_desired" {
  description = "Desired count for asg desired"
  default     = "1"
}

variable "sub_asg_ami_id" {
  description = "AMI ID of the ASG group"
  default     = "ami-b70554c8"
}

variable "pwa_asg_max" {
  description = "Desired count for asg max"
  default     = "1"
}

variable "pwa_asg_min" {
  description = "Desired count for asg min"
  default     = "1"
}

variable "pwa_asg_desired" {
  description = "Desired count for asg desired"
  default     = "1"
}

variable "pwa_asg_ami_id" {
  description = "AMI ID of the ASG group"
  default     = "ami-b70554c8"
}

variable "communication_instance_type" {
  description = "Instance type of Communication component"
  default     = "t2.medium"
}

variable "root_volume_size_asg" {
  description = "Size of the root volume in ASG"
  default     = "40"
}

variable "pwa_instance_type" {
  description = "Instance type of PWA component"
  default     = "t2.medium"
}

variable "subscription_instance_type" {
  description = "Instance type of Subscription component"
  default     = "t2.medium" 
}

variable "timesprime_instance_type" {
  description = "Instance type of Timesprime component"
  default     = "t2.medium" 
}

