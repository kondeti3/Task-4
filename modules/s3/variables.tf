variable "bucket_name" {
  description = "Name of the S3 bucket for storing Terraform state"
  type        = string
}
variable "environment" {
  description = "The environment (workspace) name"
  type        = string
}
