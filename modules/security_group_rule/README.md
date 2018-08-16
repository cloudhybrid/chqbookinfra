# AWS Terraform Module for Security Group Rule

This is a module for creating rules in aws security group using terraform.

## Usage

Here is an example of using this module:-
```hcl
module "source_vpc_default_sg_entry" {
  source            = "git::ssh://git@gitlab.com/abhishek-terraform/security_group_rule"
  cidr_block        = "0.0.0.0"
  security_group_id = "sg-abcd123"
  to_port           = "0"
  from_port         = "0"
}
```

## Variables

Here are the list of variables that used here in this module:-

|**Variable** | **Description** |
|-------------|-----------------|
|type | Type of the role ingress or egress |
|to_port | Port no. for which traffic allowing |
|from_port | Port no. from which traffic allowing |
|protocol | For which protocol you want to allow |
|cidr_block | From which CIDR block traffic should be allowed |
|security_group_id | For which security group you want to create rule |

## Outputs

Hence this is a security group rule creation module so we don't require any kind of output