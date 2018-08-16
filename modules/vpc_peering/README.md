# AWS Terraform Module for VPC Peering

This is a module to create VPC peering between two VPCs using Terraform.

## Usage

Here is an example of using this module:-

```hcl
module "vpc_peering" {
  source                    = "git::ssh://git@gitlab.com/abhishek-terraform/vpc_peering"
  peer_vpc_id               = "vpc-123abc"
  source_vpc_id             = "vpc-xyz987"
  auto_accept               = "true"
  peer_vpc_route_table_id   = "rtb-abc123"
  source_vpc_cidr           = "172.31.0.0/16"
  source_vpc_route_table_id = "rtb-xyz987"
  peer_vpc_cidr             = "10.10.0.0/16"
  source_vpc_sg_id          = "sg-abc123"
  peered_vpc_sg_id          = "sg-xyz987"
}
```

## Variables

Here are the list of variables that have used in this module:-

|**Variable** | **Description** |
|-------------|-----------------|
|peer_vpc_id | VPC ID of the requestor |
|source_vpc_id | VPC ID of the source VPC |
|auto_accept | Auto acception is enable or not. It will only work in same aws account |
|peer_vpc_route_table_id | Route table ID of the requestor VPC |
|source_vpc_cidr | VPC CIDR of the source vpc |
|source_vpc_route_table_id | Route table ID of the source VPC |
|peer_vpc_cidr | CIDR block of the peer VPC |
|source_vpc_sg_id | Security Group ID of the source VPC |
|peered_vpc_sg_id | Security Group ID of the source VPC |

## Outputs

Here is the list of outputs that will be getting after using this module:-

|**Output** | **Description** |
|-----------|-----------------|
|aws_peering_id | Output id of the aws peering connection |
