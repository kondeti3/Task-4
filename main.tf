provider "aws" {
  region = var.region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
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
  lambda_functions = [
    {
      name     = "welcomeLambda"
      handler  = "welcome_lambda.lambda_handler"
      filename = "welcomeLambda.zip"
      file_name = "welcome_lambda"
    },
    {
      name     = "greetingLambda"
      handler  = "greeting_lambda.lambda_handler"
      filename = "greetingLambda.zip"
      file_name = "greeting_lambda"
    }
  ]
}

module "api_gateway" {
  source       = "./modules/api_gateway"
  lambda_arns  = module.lambda.lambda_arns
  api_key_value = var.api_key
  existing_api_key   = var.api_key
  region         = var.region
  api_key         = var.api_key
}

output "api_id" {
  value = module.api_gateway.api_id
}

output "stage_name" {
  value = module.api_gateway.stage_name
}

data "aws_caller_identity" "current" {}
