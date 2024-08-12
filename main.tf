provider "aws" {
  region = var.region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "var.s3_bucket_name"
  environment = local.environment
}

module "secrets_manager" {
  source      = "./modules/secretsmanager"
  secret_name = var.secret_name
  api_key     = var.api_key
}

module "iam" {
  source        = "./modules/iam"
}

module "lambda" {
  source           = "./modules/lambda"
  api_gateway_rest_api_id = module.api_gateway.rest_api_id
  aws_account_id          = data.aws_caller_identity.current.account_id
  region                  = var.region
  lambda_role_arn  = var.lambda_role_arn
  s3_bucket_name   = module.s3.bucket_name
  lambda_functions = local.lambda_functions
  environment = local.environment
}

module "api_gateway" {
  source             = "./modules/api_gateway"
  api_name            = "my-api"
  api_description     = "My API Gateway"
  resources = [
    {
      path_part   = "welcome"
      http_method = "GET"
      authorization = "NONE"
    },
    {
      path_part   = "greeting"
      http_method = "POST"
      authorization = "NONE"
    }
  ]
  lambda_arns = [
    "arn:aws:lambda:${var.region}:123456789012:function:welcomeLambda",
    "arn:aws:lambda:${var.region}:123456789012:function:greetingLambda"
  ]
  region               = var.region
  stage_name           = "prod"
  api_key_name         = "api-key"
  api_key_description  = "API Key for my API"
  api_key              = var.api_key
  usage_plan_name      = "MyUsagePlan"
  usage_plan_description = "Usage plan for my API"
}

output "api_id" {
  value = module.api_gateway.api_id
}

output "stage_name" {
  value = module.api_gateway.stage_name
}

data "aws_caller_identity" "current" {}
