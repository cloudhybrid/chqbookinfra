# AWS Terraform Module for VPC

This is a terraform module which create a VPC according to your requirment.
Here is the list of things that this VPC provides:-
- VPC
- Internet Gateway
- Public route enabled with Internet Gateway
- Route 53 zone

## Usage

```hcl
module "vpc" {
    source               = "git::ssh://git@gitlab.com:abhishek-terraform/vpc"
    cidr                 = "10.10.0.0/16"
    name                 = "test-vpc"
    route53_zone_name    = "internal.test.com"
    enable_dns_hostnames = "true"
    enable_dns_support   = "true"
}
```

## Variables

Here are the list of variables:-

|**Variables** | **Description**|
|--------------|----------------|
|name | Name of the VPC to be created|
|cidr | CIDR of VPC|
|enable_dns_hostnames | Enable dns hostname or not|
|enable_dns_support | Enable dns suuport or not|
|route53_zone_name | Name of the route53 zone|

## Output

Here are the list of output:-

|**Output** | **Description**|
|-----------|----------------|
|id | Id of created VPC|
|public_route_table_id | Public route table id|
|zone_id | Zone ID of route53|
|default_sg_id | Default security group id of VPC|
