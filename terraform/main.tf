terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

module "api_gateway" {
  source = "./modules/api_gateway"

  host   = var.host
  domain = var.domain
}

module "examroom_query" {
  source = "./services/examroom_query"

  service_id = module.api_gateway.service_id
}
