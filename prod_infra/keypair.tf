module "key_pair" {
    source          = "../modules/key_pair"
    name            = "${var.prod_key_pair_name}"
    public_key_path = "../pub_keys/prod_bastion.pub"
}
