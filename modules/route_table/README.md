# AWS Terraform Module for Private Route Table
This is a terraform module which create a private route table for VPC.

Here are the list of things which this modules provides:-
- Private Route Table

## Usage

Here is the example of using this module:-

```hcl
module "private_route_table" {
  source                   = "git::ssh://git@gitlab.com:abhishek-terraform/private_route_table"
  vpc_id                   = "vpc-1-abc"
  nat_gateway_id           = "nat-gateway-1-abc"
  private_route_table_name = "private-route-table"
}
```

## Variables

|**Variable** | **Description** |
|-----------|-----------------|
|private_route_table_name | Name of your private route table |
|vpc_id | VPC id in which you want to create route table |
|nat_gateway_id | Nat Gateway ID in which should be associated to this Route Table |

## Outputs

|**Output** | **Description** |
|-----------|-----------------|
|route_table_id | ID of the route table |
