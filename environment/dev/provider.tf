provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "shivanshu-terraform-state"
    key    = locals.s3_backend
    region = "ap-south-1"
  }
}