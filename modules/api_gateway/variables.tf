variable "lambda_arns" {
  description = "ARNs of the Lambda functions"
  type        = list(string)
}

variable "api_key_value" {
  description = "API key value from Secrets Manager"
  type        = string
}

variable "existing_api_key" {
  description = "Existing API key for API Gateway"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the API"
  type        = string
}

variable "api_key" {
  description = "API key for the API Gateway"
  type        = string
}