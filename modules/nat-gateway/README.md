# AWS Terraform Module for Nat Gateway
This is a terraform module which create nat-gateway with elastic ip.

Here are the list of things which this module provides:-

- Elastic IP (For Nat-Gateway)
- Nat Gateway

## Usage

```hcl
module "nat_gateway" {
  source                  = "git::ssh://git@gitlab.com:abhishek-terraform/nat-gateway"
  subnet_id               = "subnet-1-abc"
}
```

## Variables

Here are the list of things that can passed in variables:-

|**Variables** | **Description** |
|--------------|-----------------|
|subnet_id | Subnet with you want to create Nat-Gateway |

## Outputs

Here are the list of outputs that this modules provides:-

|**Output** | **Description** |
|-----------|-----------------|
|nat_eip | The elastic IP of nat-gateway |
|nat_gateway_id | The ID of nat-gateway |
