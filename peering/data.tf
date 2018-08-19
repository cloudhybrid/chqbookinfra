data "terraform_remote_state" "timesprime-infra_management_infra" {
  backend = "s3"

  config {
    profile = "timesinternet"
    bucket = "infra-terrastate"
    key    = "donotouch/timesprime-infra/management_infra"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "timesprime-infra_prod_infra" {
  backend = "s3"

  config {
    profile = "timesinternet"
    bucket = "infra-terrastate"
    key    = "donotouch/timesprime-infra/prod_infra"
    region = "ap-south-1"
  }
}
