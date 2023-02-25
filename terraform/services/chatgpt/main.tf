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
      fileset("${path.module}/src", "index.js"),
      fileset("${path.module}/src", "package.json"),
    ) :
    filename => filemd5("${path.module}/src/${filename}")
  }
}

data "archive_file" "create_zip" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/dist/${random_uuid.lambda_src_hash.result}.zip"
}

resource "tencentcloud_scf_function" "chatgpt" {
  runtime  = "Nodejs16.13"
  timeout  = 30
  name     = "chatgpt"
  zip_file = data.archive_file.create_zip.output_path
  handler  = "index.handler"
  environment = {
    "OpenAI_API_KEY" = var.OpenAI_API_KEY
  }

  triggers {
    name = "chatgpt"
    type = "apigw"
    trigger_desc = jsonencode({
      api = {
        authRequired = "FALSE"
        requestConfig = {
          method = "POST"
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
