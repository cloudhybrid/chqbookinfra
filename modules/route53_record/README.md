# AWS Terraform Module for Route53 Record

This is a terraform module which provides capability to create a route53 record with Terraform

Here are the list of thing that this module provides:-
- Route53 record

## Usage

Here is the example of using this module:-
```hcl
module "route53_record" {
    source              = "git::ssh://git@gitlab.com/abhishek-terraform/route53_record"
    zone_id             = "zone-abcd123"
    name                = "test.example.com"
    instance_private_ip = "10.10.12.45"
}
```

## Variables

Here are the list of variables that used in this module:-

|**Variable** | **Description** |
|-------------|-----------------|
|zone_id | Zone ID in which you want to create route53 record |
|name | Name of the instance that you want in route53 with domain name for example:- test.example.com |
|instance_private_ip | EC2 instance private IP with you want to associate your route53 record |

## Outputs

Here are the list of output you will get using this module:-

|**Output** | **Description** |
|-----------|-----------------|
|route53_name | Name of your route53 record |
