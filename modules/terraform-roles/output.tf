output "terraform_role_arn" {
  value       = aws_iam_role.tre_terraform.arn
  description = "ARN of the TRE Environments Terraform Role"
}

output "tre_terraform_backend_role_arn" {
  value       = aws_iam_role.tre_terraform_backend.arn
  description = "ARN of the TRE Terraform Backend Role"
}

output "tre_terraform_iam_policy" {
  value       = aws_iam_policy.tre_terraform_iam.arn
  description = "ARN of the TRE Terraform IAM Policy"
}

output "tre_terraform_policy" {
  value       = aws_iam_policy.tre_terraform.arn
  description = "ARN of the TRE Terraform Policy"
}

output "tre_permission_boundary" {
  value       = aws_iam_policy.tre_permission_boundary.arn
  description = "ARN of the TRE Role Permission Boundary"
}
