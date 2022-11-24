output "tre_open_id_connect_roles" {
  value       = { for key, value in aws_iam_role.tre_github_actions_open_id_connect : key => value.arn }
  description = "ARN of the tre-github-actions-open-id-connect-role"
}
