output "terraform_role_arn" {
  value       = aws_iam_role.tre_terraform.arn
  description = "ARN of the TRE Environments Terraform Role"
}

output "tre_terraform_backend_role_arn" {
  value       = aws_iam_role.tre_terraform_backend.arn
  description = "ARN of the TRE Terraform Backend Role"
}
