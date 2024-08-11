terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-007"
    key    = "terraform.tfstate"
    region = "us-west-1"
  }
}
