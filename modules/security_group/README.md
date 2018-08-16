# AWS Terraform Module for Security Group

This is a terraform module for creating Security Group with Terraform

## Usage

Here are the some examples of using this module:-

**Simple Module to create Security Group with default port and CIDR**

```hcl
module "secuirty_gorup" {
  source              = "git::ssh://git@gitlab.com/abhishek-terraform/security_group"
  vpc_id              = "vpc-ca5045b2"
  name                = "test-sg"
  ingress_cidr_blocks = ["172.16.0.0/24"]
  ingress_rules       = ["http-rule", "ssh-rule"]
}
```

**Use this method if you want to add rules to existing Security Group**

```hcl
module "secuirty_gorup" {
  source                  = "git::ssh://git@gitlab.com/abhishek-terraform/security_group"
  vpc_id                  = "vpc-ca5045b2"
  rule_create             = false
  create                  = false
  existing_sg_rule_create = true
  security_group_id       = "sg-8388383"

  ingress_with_cidr_blocks = [
    {
      rule = "https-rule"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule       = "ssh-rule"
      cidr_block = "0.0.0.0/0"
    },
  ]
}
```

**If you want to create your own custom TCP rule with CIDR block in Security Group, you can follow this method**
```hcl
module "secuirty_gorup" {
  source                  = "git::ssh://git@gitlab.com/abhishek-terraform/security_group"
  vpc_id                  = "vpc-ca5045b2"
  name                    = "test-sg"

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Custom Service Port"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule = "https-rule"

      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule       = "ssh-rule"
      cidr_block = "0.0.0.0/0"
    },
  ]
}
```

**If you want to create your security group and you want use other security group id rather than cidr_block use this**

```hcl
module "secuirty_gorup" {
  source                  = "git::ssh://git@gitlab.com/abhishek-terraform/security_group"
  vpc_id                  = "vpc-ca5045b2"
  name                    = "test-sg"

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-rule"
      source_security_group_id = "sg-98989"
    },
    {
      from_port                = 8080
      to_port                  = 8090
      protocol                 = "tcp"
      description              = "User-service ports"
      source_security_group_id = "sg-0987"
    },
  ]
}
```

**If you already have your security group and you just want to add rules by sourcing other security group, use this**

```hcl
module "secuirty_gorup" {
  source                  = "git::ssh://git@gitlab.com/abhishek-terraform/security_group"
  vpc_id                  = "vpc-ca5045b2"
  rule_create             = false
  create                  = false
  existing_sg_rule_create = true
  security_group_id       = "sg-8388383"

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-rule"
      source_security_group_id = "sg-98989"
    },
    {
      from_port                = 8080
      to_port                  = 8090
      protocol                 = "tcp"
      description              = "User-service ports"
      source_security_group_id = "sg-0987"
    },
  ]
}
```

**If you want to use computed values in this module you can use like this**
```hcl
module "secuirty_gorup" {
  source                                      = "git::ssh://git@gitlab.com/abhishek-terraform/security_group"
  vpc_id                                      = "${module.vpc.id}"
  name                                        = "inventory-connectivity-sg"
  number_of_computed_ingress_with_cidr_blocks = "1"

  computed_ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQl connectivity"
      cidr_blocks = "${module.instance.private_ips[0]}/32"
    },
  ]
}
```

## Variables

|**Variables** | **Description**|
|----------|------------|
|create | Whether to create security group and all rules |
|vpc_id | ID of the VPC where to create security group |
|ingress_rules | List of ingress rules to create by name, For ex:- ssh-rule,http-rule |
|ingress_cidr_blocks | List of IPv4 CIDR ranges to use on all ingress rules |
|description | Description of security group |
|name | Name of Security Group |
|rules | Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description']) |
|ingress_with_cidr_blocks | List of ingress rules to create where 'cidr_blocks' is used |
|existing_sg_rule_create | Mark true if you want to create rule for existing security group |
|security_group_id | Security group id if you want to add rules to existing sg |
|ingress_with_source_security_group_id | List of ingress rules to create where 'source_security_group_id' is used |
|number_of_computed_ingress_rules | Number of computed ingress rules to create by name |
|computed_ingress_rules | List of computed ingress rules to create by name |
|computed_ingress_with_cidr_blocks | List of computed ingress rules to create where 'cidr_blocks' is used |
|egress_cidr_blocks | List of IPv4 CIDR ranges to use on all egress rules |
|rules | Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description', 'cidr_block', 'security_group_id |


## Outputs

|**Output** | **Description** |
|-----------|-----------------|
|id | ID of the created security group |
