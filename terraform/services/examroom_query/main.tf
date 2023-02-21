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
      fileset("${path.module}/dist", "index.js"),
    ) :
    filename => filemd5("${path.module}/dist/${filename}")
  }
}

data "archive_file" "create_zip" {
  type        = "zip"
  source_file = "${path.module}/dist/index.js"
  output_path = "${path.module}/dist/${random_uuid.lambda_src_hash.result}.zip"
}

resource "tencentcloud_scf_function" "examroom" {
  runtime  = "Nodejs16.13"
  name     = "examroom"
  zip_file = data.archive_file.create_zip.output_path
  handler  = "index.handler"

  triggers {
    name = "examroom"
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
