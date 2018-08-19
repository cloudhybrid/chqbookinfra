  terraform {
    backend "s3" {
      profile = "timesinternet"
      encrypt = true
      bucket = "infra-terrastate"
      key = "donotouch/timesprime-infra/core/mgmt_core"
      region = "ap-south-1"
    }
  }
