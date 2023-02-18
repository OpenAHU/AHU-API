terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

variable "host" {
  type = string
}

variable "domain" {
  type = string
}

resource "tencentcloud_dnspod_domain_instance" "dnspod_domain_instance" {
  domain = var.domain
}

resource "tencentcloud_dnspod_record" "host_dnspod_record" {
  record_type = "A"
  record_line = "默认"
  value       = var.host
  domain      = tencentcloud_dnspod_domain_instance.dnspod_domain_instance.domain
}

resource "tencentcloud_api_gateway_service" "api_gateway_service" {
  protocol     = "http"
  net_type     = ["OUTER"]
  service_name = "api_gateway_service"
}

resource "tencentcloud_dnspod_record" "api_dnspod_record" {
  sub_domain  = "api"
  record_line = "默认"
  record_type = "CNAME"
  domain      = tencentcloud_dnspod_domain_instance.dnspod_domain_instance.domain
  value       = tencentcloud_api_gateway_service.api_gateway_service.outer_sub_domain
}

resource "tencentcloud_api_gateway_custom_domain" "custom_domain" {
  protocol       = "http"
  net_type       = "OUTER"
  service_id     = tencentcloud_api_gateway_service.api_gateway_service.id
  default_domain = tencentcloud_api_gateway_service.api_gateway_service.outer_sub_domain
  sub_domain     = join(".", [tencentcloud_dnspod_record.api_dnspod_record.sub_domain, tencentcloud_dnspod_record.api_dnspod_record.domain])
}

output "service_id" {
  value = tencentcloud_api_gateway_service.api_gateway_service.id
}
