output "tre_v2_github_action_testing_role_arn" {
  value = aws_iam_role.v2_github_action_testing.arn
  description = "ARN of the v2 GitHub Action Testing Role"
}

output "tre_v2_github_action_testing_policy_arn" {
  value = aws_iam_policy.v2_github_action_testing.arn
  description = "ARN of the v2 GitHub Action Testing Role"
}