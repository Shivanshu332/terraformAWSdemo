resource "aws_s3_bucket" "demos3" {
    bucket = "shivanshu-s3-demo"
    tags = {
        name = "shivanshu-s3-demo"
        description = "Demo s3 bucket"
    }
}
