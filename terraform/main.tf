terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

provider "tencentcloud" {}

module "examroom_query" {
  source = "./services/examroom_query"
}
