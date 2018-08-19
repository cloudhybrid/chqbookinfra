  terraform {
    backend "s3" {
      profile = "timesinternet"
      encrypt = true
      bucket = "infra-terrastate"
      key = "donotouch/timesprime-infra/prod_infra"
      region = "ap-south-1"
    }
  }
