variable "secret_id" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}

variable "region" {
  type      = string
  sensitive = true
}

variable "domain" {
  type      = string
  sensitive = true
}

variable "certificate_id" {
  type      = string
  sensitive = true
}

variable "OpenAI_API_KEY" {
  type      = string
  sensitive = true
}

variable "authed_xhs" {
  type      = string
  sensitive = true
}
