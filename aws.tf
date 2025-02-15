resource "aws_s3_bucket" "demos3" {
    bucket = "shivanshu-aws-s3-demo"
    tags = {
        name = "shivanshu-aws-s3-demo"
        description = "Demo s3 bucket"
    }
}
