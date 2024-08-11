variable "secret_name" {
  description = "Name of the secret in Secrets Manager"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for storing Terraform state"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "api_key" {
  description = "API key to store in Secrets Manager"
  type        = string
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda functions"
  type        = string
}

variable "lambda_functions" {
  description = "List of Lambda function configurations"
  type = list(object({
    name     = string
    handler  = string
    filename = string
  }))
}