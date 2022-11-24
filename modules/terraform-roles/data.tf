data "aws_iam_policy_document" "tre_assume_role_terraform" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.tre_open_id_connect_roles]
    }
  }
}

data "aws_iam_policy_document" "tre_assume_role_break_glass" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.tre_open_id_connect_platform_role]
    }
  }
}
