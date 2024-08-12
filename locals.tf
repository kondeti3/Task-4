locals {
  environment = terraform.workspace
  lambda_functions = [
    {
      name        = "welcomeLambda"
      handler     = "welcome_lambda.lambda_handler"
      filename    = "welcomeLambda.zip"
      file_name   = "welcome_lambda"
      http_method = "GET"
      path        = "welcome"
    },
    {
      name        = "greetingLambda"
      handler     = "greeting_lambda.lambda_handler"
      filename    = "greetingLambda.zip"
      file_name   = "greeting_lambda"
      http_method = "POST"
      path        = "greeting"
    }
  ]
}
