terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

resource "tencentcloud_api_gateway_service" "api_gateway_service" {
  protocol     = "https"
  net_type     = ["OUTER"]
  service_name = "api_gateway_service"
}

resource "tencentcloud_dnspod_record" "api_dnspod_record" {
  sub_domain  = "api"
  record_line = "默认"
  record_type = "CNAME"
  domain      = var.domain
  value       = tencentcloud_api_gateway_service.api_gateway_service.outer_sub_domain
}

resource "tencentcloud_api_gateway_custom_domain" "custom_domain" {
  protocol       = "https"
  certificate_id = var.certificate_id
  net_type       = "OUTER"
  service_id     = tencentcloud_api_gateway_service.api_gateway_service.id
  default_domain = tencentcloud_api_gateway_service.api_gateway_service.outer_sub_domain
  sub_domain     = join(".", [tencentcloud_dnspod_record.api_dnspod_record.sub_domain, tencentcloud_dnspod_record.api_dnspod_record.domain])
}
