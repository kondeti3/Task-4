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