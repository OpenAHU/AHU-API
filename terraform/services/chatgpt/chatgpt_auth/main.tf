terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset("${path.module}/src", "index.py"),
      fileset("${path.module}/src", "requirements.txt"),
    ) :
    filename => filemd5("${path.module}/src/${filename}")
  }
}

data "archive_file" "create_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/dist/${random_uuid.lambda_src_hash.result}.zip"
}

resource "tencentcloud_scf_function" "chatgpt_auth" {
  runtime  = "Python3.7"
  name     = "chatgpt_auth"
  zip_file = data.archive_file.create_zip.output_path
  handler  = "index.handler"
  environment = {
    "AUTHED_XHS" = var.authed_xhs
  }

  triggers {
    name = "chatgpt_auth"
    type = "apigw"
    trigger_desc = jsonencode({
      api = {
        authRequired = "FALSE"
        requestConfig = {
          method = "GET"
        }
        isIntegratedResponse = "FALSE"
      }
      service = {
        serviceId = var.service_id
      }
      release = {
        environmentName = "release"
      }
    })
  }
}
