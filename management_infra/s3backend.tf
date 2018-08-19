  terraform {
    backend "s3" {
      profile = "timesinternet"
      encrypt = true
      bucket = "infra-terrastate"
      key = "donotouch/timesprime-infra/management_infra"
      region = "ap-south-1"
    }
  }
