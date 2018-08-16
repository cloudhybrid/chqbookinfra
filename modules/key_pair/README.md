# AWS Terraform Module for Key Pair

This is a module for creating key-pair with Terraform

## Usage
Here is an example of using this module:-
```hcl
module "key_pair" {
    source          = "git::ssh://git@gitlab.com:abhishek-terraform/key_pair"
    name            = "my_key"
    public_key_path = "~/.ssh/id_rsa.pub"
}
```

## Variables

Here are the list of variables used in this modules:-

|**Variable** | **Description** |
|-------------|-----------------|
|name | Name of your key-pair |
|public_key_path | Path of yoour public key on your local machine |

## Outputs

|**Output** | **Description** |
|-----------|-----------------|
|id | ID of key-pair |
