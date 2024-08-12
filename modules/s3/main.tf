resource "aws_s3_bucket" "state_bucket" {
  bucket = "${var.environment}-terraform-state-bucket-007"
  force_destroy  = true
}
