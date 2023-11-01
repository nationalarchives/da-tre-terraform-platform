# da-transform-sample-data bucket
resource "aws_s3_bucket" "da_transform_sample_data" {
  bucket = "da-transform-sample-data"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "da_transform_sample_data" {
  bucket = aws_s3_bucket.da_transform_sample_data.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "alias/s3/platform/da-transform-sample-data"
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "da_transform_sample_data" {
  bucket = aws_s3_bucket.da_transform_sample_data.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "da_transform_sample_data" {
  bucket                  = aws_s3_bucket.da_transform_sample_data.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "da_transform_sample_data" {
  bucket = aws_s3_bucket.da_transform_sample_data.bucket
  policy = data.aws_iam_policy_document.da_transform_sample_data_bucket.json
}
