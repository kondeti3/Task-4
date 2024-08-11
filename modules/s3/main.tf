resource "aws_s3_bucket" "state_bucket" {
  bucket_prefix = "terraform-state-"
  force_destroy  = true
}
