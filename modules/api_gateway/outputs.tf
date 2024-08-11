output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "api_endpoint" {
  value = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.stage.stage_name}"
}

output "stage_name" {
  value = aws_api_gateway_deployment.deployment.stage_name
}

output "rest_api_id" {
  value = aws_api_gateway_rest_api.api.id
}