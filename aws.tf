resource "aws_s3_bucket" "demos3" {
    bucket = "shivanshu-aws-s3-demo"
    tags = {
        name = "shivanshu-aws-s3-demo"
        description = "Demo s3 bucket"
    }
}
terraform {
    backend "s3" {
        bucket = "shivanshu-terraform-state" 
        key    = "terraform-s3/s3state.tfstate"
        region = "ap-south-1"
    }
}