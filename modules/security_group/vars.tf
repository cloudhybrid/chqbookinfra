variable "create" {
  description = "Whether to create security group and all rules"
  default     = true
}

variable "rule_create" {
  description = "Whether to create security group and all rules"
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  default     = ""
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name"

  #   default     = ["http-80-tcp", "ssh"]
  default = []
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  default     = ["0.0.0.0/0"]
}

variable "description" {
  description = "Description of security group"
  default     = "Security Group managed by Terraform"
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  default     = []
}

variable "existing_sg_rule_create" {
  default = false
}

variable "security_group_id" {
  default = ""
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  default     = []
}

variable depends_on { 
  type = "list"
  default = [] 
}

variable "number_of_computed_ingress_rules" {
  description = "Number of computed ingress rules to create by name"
  default     = 0
}

variable "computed_ingress_rules" {
  description = "List of computed ingress rules to create by name"
  default     = []
}

variable "computed_ingress_with_cidr_blocks" {
  description = "List of computed ingress rules to create where 'cidr_blocks' is used"
  default     = []
}

variable "number_of_computed_ingress_with_cidr_blocks" {
  description = "Number of computed ingress rules to create where 'cidr_blocks' is used"
  default     = 0
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used"
  default     = []
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  default     = ["0.0.0.0/0"]
}

variable "computed_ingress_with_source_security_group_id" {
  description = "List of computed ingress rules to create where 'source_security_group_id' is used"
  default     = []
}

variable "number_of_computed_ingress_with_source_security_group_id" {
  description = "Number of computed ingress rules to create where 'source_security_group_id' is used"
  default     = 0
}
