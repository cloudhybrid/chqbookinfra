# AWS Terraform Module for EC2

This is a terraform module which provides capability to launch ec2 instance

This modules provides:-
- EC2 Instance

## Usage

Here is an example of using this module:-
```hcl
module "instance" {
    source               = "git::ssh://git@gitlab.com/abhishek-terraform/ec2"
    name                 = "my-instance"
    instance_type        = "t2.micro"
    subnet_id            = "subnet-abcd123"
    number_of_instances  = 1
    key_name             = "my-key"
    iam_instance_profile = "ec2-iam-role"
    aws_region_os        = "us-east-1-ubuntu"
    root_volume_type     = "gp2"
    root_volume_size     = "30"
    security_group_ids   = ["sg-abcd123"]
}
```

## Variables

Here are the list of variables that are using in this module:-

|**Variable** | **Description** |
|-------------|-----------------|
|name | Name of the ec2 instance |
|instance_type | Instance type such as flavors like:- t2.nano,t2.micro |
|subnet_id | Subnet ID on which you want to launch ec2 |
|number_of_instances | Number of instances you want to launch of this configuration |
|key_name | Name of the key that attached to ec2 instance to access it |
|iam_instance_profile | Any special permission via using Instance profile |
|aws_ami_map | To map the value of AMI region wise |
|aws_region_os | OS flavor that should be associated with ec2 instance |
|user_data | User data for ec2 instance |
|root_volume_type | Volume type of root for ec2 |
|root_volume_size | Volume size of root for ec2 |
|security_group_ids | List of security group that you want to associate with ec2 |
|associate_public_ip_address| Public is enabled or not |

## Outputs

Here are the list of outputs of this module:-

|**Output** | **Description** |
|-----------|-----------------|
|public_ip | Public IP of ec2 instance |
|id | Instance ID of ec2 instance |
|private_ip | Private IP of ec2 instance |
