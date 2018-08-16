# AWS Terraform Module for Subnet

This is a terraform module which create subnet according to your requirments.
Here is the list of things that this resource provides:-
- Subnet

## Usage
If you want to use this module you can use like this:-

```hcl
module "subent" {
  source                  = "git::ssh://git@gitlab.com:abhishek-terraform/subnet"
  vpc_id                  = "vpc-1234"
  cidr                    = "10.10.0.0/20"
  az                      = "us-east-1a"
  name                    = "private_subnet"
  map_public_ip_on_launch = "false"
}
```

## Variables
Here are the list of variables:-

|**Variables** | **Description** |
|--------------|-----------------|
|vpc_id | ID of VPC in which subnet should be created |
|cidr | CIDR block of subnet |
|az | Availability zone in which subnet should be created |
|name | Name of the subnet |
|map_public_ip_on_launch | Whether to map Public IP or not |

## Outputs

Here are the list of outputs of this module:-

|**Output** | **Description** |
|-----------|-----------------|
|id | Output ID of subnet |