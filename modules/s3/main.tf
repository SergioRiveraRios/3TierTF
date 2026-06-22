resource "aws_s3_bucket" "example" {
  bucket = "${var.bucket_name}"
  region = "${var.bucket_region}"
  tags = {
    Name        = "My bucket"
  }
}