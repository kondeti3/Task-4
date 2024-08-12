variable "api_name" {
  description = "The name of the API"
  type        = string
}

variable "api_description" {
  description = "The description of the API"
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

variable "lambda_arns" {
  description = "List of Lambda ARNs for integration"
  type = list(string)
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "stage_name" {
  description = "The name of the stage"
  type        = string
}

variable "api_key_name" {
  description = "The name of the API key"
  type        = string
}

variable "api_key_description" {
  description = "The description of the API key"
  type        = string
}

variable "api_key" {
  description = "The API key value"
  type        = string
}

variable "usage_plan_name" {
  description = "The name of the usage plan"
  type        = string
}

variable "usage_plan_description" {
  description = "The description of the usage plan"
  type        = string
}
