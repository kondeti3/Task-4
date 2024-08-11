# API Gateway Rest API
resource "aws_api_gateway_rest_api" "api" {
  name        = "my-api"
  description = "My API Gateway"
}

# API Gateway Resources
resource "aws_api_gateway_resource" "get_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "welcome"
}

resource "aws_api_gateway_resource" "post_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "greeting"
}

# GET Method for Welcome Lambda
resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# POST Method for Greeting Lambda
resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.post_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Lambda Integration for GET
resource "aws_api_gateway_integration" "integration_get" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_resource.id
  http_method             = aws_api_gateway_method.get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arns[0]}/invocations"
}

# Lambda Integration for POST
resource "aws_api_gateway_integration" "integration_post" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.post_resource.id
  http_method             = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_arns[1]}/invocations"
}


# Deployment
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_method.get_method,
    aws_api_gateway_method.post_method,
    aws_api_gateway_integration.integration_get,
    aws_api_gateway_integration.integration_post
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

# API Gateway Stage
resource "aws_api_gateway_stage" "stage" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id
}

# API Key
resource "aws_api_gateway_api_key" "api_key" {
  name        = "api-key"
  description = "API Key for my API"
  value       = var.api_key
  enabled     = true
}

# Usage Plan
resource "aws_api_gateway_usage_plan" "usage_plan" {
  name        = "MyUsagePlan"
  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.stage.stage_name
  }
  description = "Usage plan for my API"
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.usage_plan.id
}
