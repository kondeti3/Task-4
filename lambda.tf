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