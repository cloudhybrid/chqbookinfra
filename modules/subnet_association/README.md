# AWS Terraform Module for Subnet Association

This is a terraform module which provides subnet association capability for your subnets

This modules provides:-
- Subnet Association

## Usage
Here is the example for using this module:-
```hcl
module "pub_sn_a_association" {
  source           = "git::ssh://git@gitlab.com:abhishek-terraform/subnet_association"
  subnet_id        = "subnet-abcd123"
  route_table_id   = "rtb-abcd123"
}
```

## Variables
Here are the list of variables that you have to pass while running this module

|**Variable** | **Description** |
|-------------|-----------------|
|subnet_id | Subnet ID that you want to associate |
|route_table_id | Route table id with you want to associate subnet |

## Outputs

There are no required output for this module