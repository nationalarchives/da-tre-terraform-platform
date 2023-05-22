data "aws_iam_policy_document" "tre_assume_role_terraform" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = var.roles_can_assume_terraform_role
    }
  }
}

data "aws_iam_policy_document" "tre_assume_role_terraform_backend" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = var.roles_can_assume_terraform_backend_role
    }
  }
}
