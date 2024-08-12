resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = var.api_description
}

resource "aws_api_gateway_resource" "resource" {
  count      = length(var.resources)
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.resources[count.index].path_part
}

resource "aws_api_gateway_method" "method" {
  count        = length(var.resources)
  rest_api_id  = aws_api_gateway_rest_api.api.id
  resource_id  = aws_api_gateway_resource.resource[count.index].id
  http_method  = var.resources[count.index].http_method
  authorization = var.resources[count.index].authorization
}

resource "aws_api_gateway_integration" "integration" {
  count                    = length(var.resources)
  rest_api_id              = aws_api_gateway_rest_api.api.id
  resource_id              = aws_api_gateway_resource.resource[count.index].id
  http_method              = aws_api_gateway_method.method[count.index].http_method
  integration_http_method  = "POST"
  type                     = "AWS_PROXY"
  uri                      = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arns[count.index]}/invocations"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_method.method,
    aws_api_gateway_integration.integration
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage_name
}

resource "aws_api_gateway_stage" "stage" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}

resource "aws_api_gateway_api_key" "api_key" {
  name        = var.api_key_name
  description = var.api_key_description
  value       = var.api_key
  enabled     = true
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  name        = var.usage_plan_name
  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.stage.stage_name
  }
  description = var.usage_plan_description
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
}
