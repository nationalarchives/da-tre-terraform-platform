data "aws_iam_policy_document" "da_transform_sample_data_bucket" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject"
    ]

    principals {
      type = "AWS"
      identifiers = [
        var.account_id_prod,
        var.account_id_nonprod
      ]
    }

    resources = ["${aws_s3_bucket.da_transform_sample_data.arn}/*", aws_s3_bucket.da_transform_sample_data.arn]
  }
}

data "aws_iam_policy_document" "da_transform_sample_data_bucket_kms" {

  statement {
    sid     = "Allow access for Key Administrators"
    actions = ["kms:*"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id_mgmnt}:root"]
    }

    resources = ["*"]
  }

  statement {
    sid    = "Allow sample data readers key"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        var.account_id_prod,
        var.account_id_nonprod
      ]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt"
    ]
    resources = ["*"]
  }
}
