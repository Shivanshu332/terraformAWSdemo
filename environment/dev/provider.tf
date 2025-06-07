provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "shivanshu-terraform-state"
    key    = "terraform-ec2-dev/ec2state.tfstate"
    region = "ap-south-1"
  }
}