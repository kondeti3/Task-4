resource "aws_secretsmanager_secret" "api_key" {
  name        = var.secret_name
  description = "API key for API Gateway"
}

resource "aws_secretsmanager_secret_version" "api_key_version" {
  secret_id     = aws_secretsmanager_secret.api_key.id
  secret_string = var.api_key
}
