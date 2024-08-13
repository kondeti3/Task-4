module "secrets_manager" {
  source      = "./modules/secretsmanager"
  secret_name = var.secret_name
  api_key     = var.api_key
}
