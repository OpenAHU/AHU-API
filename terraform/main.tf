terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

module "api_gateway" {
  source = "./modules/api_gateway"

  domain         = var.domain
  certificate_id = var.certificate_id
}

module "examroom_query" {
  depends_on = [module.api_gateway]
  source     = "./services/examroom_query"

  service_id = module.api_gateway.service_id
}
