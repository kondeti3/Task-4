resource "aws_lambda_function" "lambda" {
  count = length(var.lambda_functions)

  function_name = var.lambda_functions[count.index].name
  handler       = "${var.lambda_functions[count.index].file_name}.lambda_handler"
  runtime       = "python3.9"

  s3_bucket        = "terraform-state-bucket-007"
  s3_key           = "lambda/${var.lambda_functions[count.index].filename}"
  role             = var.lambda_role_arn

      source_code_hash = filebase64sha256("${path.module}/${var.lambda_functions[count.index].filename}")
}

resource "aws_lambda_permission" "allow_apigateway_get" {
  statement_id  = "AllowExecutionFromAPIGatewayGet"
  action        = "lambda:InvokeFunction"
  function_name = "welcomeLambda" # Or use the correct reference if using variables
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.aws_account_id}:${var.api_gateway_rest_api_id}/*/GET/welcome"
}

resource "aws_lambda_permission" "allow_apigateway_post" {
  statement_id  = "AllowExecutionFromAPIGatewayPost"
  action        = "lambda:InvokeFunction"
  function_name = "greetingLambda" # Or use the correct reference if using variables
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.aws_account_id}:${var.api_gateway_rest_api_id}/*/POST/greeting"
}
