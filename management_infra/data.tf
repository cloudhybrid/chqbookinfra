data "terraform_remote_state" "timesprime-infra_management_infra" {
  backend = "s3"

  config {
    profile = "timesinternet"
    bucket = "infra-terrastate"
    key    = "donotouch/timesprime-infra/core/mgmt_core"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "timesprime-infra_prod_infra" {
  backend = "s3"

  config {
    profile = "timesinternet"
    bucket = "infra-terrastate"
    key    = "donotouch/timesprime-infra/core/prod_core"
    region = "ap-south-1"
  }
}
