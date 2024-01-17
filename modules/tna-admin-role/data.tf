data "aws_iam_policy_document" "admin_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [ var.admin_user_arn ]
    }
  }
}
