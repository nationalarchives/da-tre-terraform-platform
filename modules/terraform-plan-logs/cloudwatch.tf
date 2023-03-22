resource "aws_cloudwatch_log_group" "tre-github-actions-logs" {
  for_each = toset(["dev", "test", "int", "staging", "prod", "tf-backend", "platform", "pte"])
  name     = "${var.prefix}-${each.key}-github-actions-logs"
}
