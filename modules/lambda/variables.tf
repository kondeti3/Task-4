variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda functions"
  type        = string
}

variable "lambda_functions" {
  description = "List of Lambda function configurations"
  type = list(object({
    name     = string
    handler  = string
    filename = string
    file_name = string
    http_method = string
    path        = string
  }))
}

variable "env_vars" {
  description = "Environment variables for Lambda functions"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "api_gateway_rest_api_id" {
  description = "The ID of the API Gateway Rest API"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "api_methods" {
  type = map(object({
    method = string
    path   = string
  }))
  default = {
    GET_welcome   = { method = "GET", path = "welcome" }
    POST_greeting = { method = "POST", path = "greeting" }
  }
}

