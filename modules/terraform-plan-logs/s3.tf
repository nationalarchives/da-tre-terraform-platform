resource "aws_s3_bucket" "terraform_plan" {
  bucket = "${var.env}-${var.prefix}-terraform-plan"
}

resource "aws_s3_bucket_acl" "terraform_plan" {
  bucket = aws_s3_bucket.terraform_plan.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_plan" {
  bucket = aws_s3_bucket.terraform_plan.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_plan" {
  bucket = aws_s3_bucket.terraform_plan.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_plan" {
  bucket                  = aws_s3_bucket.terraform_plan.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
