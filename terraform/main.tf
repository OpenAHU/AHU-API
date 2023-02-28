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

module "weather_query" {
  depends_on = [module.api_gateway]
  source     = "./services/weather_query"

  service_id = module.api_gateway.service_id
}

module "chatgpt" {
  depends_on = [module.api_gateway]
  source     = "./services/chatgpt"

  service_id     = module.api_gateway.service_id
  OpenAI_API_KEY = var.OpenAI_API_KEY
}

module "chatgpt_auth" {
  depends_on = [module.api_gateway]
  source     = "./services/chatgpt/chatgpt_auth"

  service_id = module.api_gateway.service_id

  authed_xhs = var.authed_xhs
}
