data "aws_iam_policy_document" "v2_github_action_testing" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = var.roles_can_assume_v2_github_action_testing_role
    }
  }
}
