resource "aws_lambda_function" "lambda" {
  count = length(var.lambda_functions)

  function_name = "${var.environment}-${var.lambda_functions[count.index].name}"
  handler       = "${var.lambda_functions[count.index].file_name}.lambda_handler"
  runtime       = "python3.9"

  s3_bucket        = "terraform-state-bucket-007"
  s3_key           = "lambda/${var.lambda_functions[count.index].filename}"
  role             = var.lambda_role_arn

      source_code_hash = filebase64sha256("${path.module}/${var.lambda_functions[count.index].filename}")
}

resource "aws_lambda_permission" "allow_apigateway" {
  for_each = {
    for idx, lambda in var.lambda_functions : "${var.environment}-${lambda.name}-${lambda.http_method}-${lambda.path}" => lambda
  }

  statement_id  = "AllowExecutionFromAPIGateway-${each.value.name}-${each.value.http_method}-${each.value.path}"
  action        = "lambda:InvokeFunction"
  function_name = "${var.environment}-${each.value.name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.aws_account_id}:${var.api_gateway_rest_api_id}/*/${each.value.http_method}/${each.value.path}"
  depends_on = [aws_lambda_function.lambda]
}

