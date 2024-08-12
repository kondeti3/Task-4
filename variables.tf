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

variable "api_name" {
  description = "The name of the API"
  type        = string
}

variable "usage_plan_description" {
  description = "Description for the usage plan"
  type        = string
}
variable "resources" {
  description = "List of API Gateway resources"
  type = list(object({
    path_part   = string
    http_method = string
    authorization = string
  }))
}
variable "api_key_description" {
  description = "The description of the API key"
  type        = string
}
variable "api_key_name" {
  description = "The name of the API key"
  type        = string
}
variable "usage_plan_name" {
  description = "The name of the usage plan"
  type        = string
}
variable "api_description" {
  description = "The description of the API"
  type        = string
}
variable "stage_name" {
  description = "The name of the stage"
  type        = string
}
