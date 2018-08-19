terraform {
  backend "s3" {
    profile = "timesinternet"
    encrypt = true
    bucket = "infra-terrastate"
    key = "donotouch/timesprime-infra/peering"
    region = "ap-south-1"
  }
}
