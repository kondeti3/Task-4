output "lambda_arns" {
  value = aws_lambda_function.lambda[*].arn
}
