/*data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "terraform_tfstate" {
  bucket           = format("tfstate-bucket-%s-%s-an", data.aws_caller_identity.current.account_id, data.aws_region.current.region)
  bucket_namespace = "account-regional"
  object_lock_enabled = true
}

resource "aws_s3_bucket_versioning" "terraform_tfstate" {
  bucket = aws_s3_bucket.terraform_tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "terraform_tfstate" {
  bucket = aws_s3_bucket.terraform_tfstate.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 5
    }
  }
}*/