resource "aws_iam_role" "v2_github_action_testing" {
  name               = "${var.prefix}-v2-github-action-testing"
  assume_role_policy = data.aws_iam_policy_document.v2_github_action_testing.json
}

resource "aws_iam_policy" "v2_github_action_testing" {
  name = "${var.prefix}-v2-github-action-testing"
  policy = templatefile(var.v2_github_action_testing_policy_path, {
    aws_region  = var.aws_region
    account_id  = var.account_id
  })
}

resource "aws_iam_role_policy_attachment" "v2_github_action_testing" {
  role       = aws_iam_role.v2_github_action_testing.name
  policy_arn = aws_iam_policy.v2_github_action_testing.arn
}
