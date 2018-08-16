variable "vpc_id" { 
    description = "ID of VPC in which subnet should be created"
}

variable "cidr" { 
    description = "CIDR block of subnet"
}

variable "az" { 
    description = "Availability zone in which subnet should be created"
}

variable "name" {
    description = "Name of the subnet"
}

variable "map_public_ip_on_launch" {
    description = "Whether to map Public IP or not"
}
