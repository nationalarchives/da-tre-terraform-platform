data "aws_iam_policy_document" "da_transform_sample_data_bucket" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]

    principals {
      type        = "AWS"
      identifiers = [
        var.account_id_prod,
        var.account_id_nonprod
      ]
    }

    resources = ["${aws_s3_bucket.da_transform_sample_data.arn}/*", aws_s3_bucket.da_transform_sample_data.arn]
  }
}