data "terraform_remote_state" "timesprime-infra_management_infra" {
  backend = "s3"

  config {
    bucket = "infra-terrastate"
    key    = "donotouch/timesprime-infra/management_infra"
    region = "ap-south-1"
  }
}
