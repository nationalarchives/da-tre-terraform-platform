resource "aws_cloudwatch_log_group" "tre-terraform-plan" {
  for_each = toset([ "dev", "test", "int", "staging", "prod", "tf-backend", "platform"  ])
  name = "${var.prefix}-${each.key}-terraform-plan"
}

resource "aws_cloudwatch_log_group" "tre_github_actions_error" {
  name = "${var.prefix}-github-actions-error"
}
