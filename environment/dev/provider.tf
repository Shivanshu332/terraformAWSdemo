provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "shivanshu-terraform-state"
    key    = local.s3_backend
    region = "ap-south-1"
  }
}