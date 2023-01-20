variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}

variable "tre_github_actions_open_id_connect_roles" {
  description = "List TRE repositories that require access to tre AWS Accounts"
  type = list(object({
    name             = string
    tre_repositories = list(string)
  }))
}

variable "tre_github_actions_open_id_connect_policies" {
  description = "List TRE repositories that require access to tre AWS Accounts"
  type = list(object({
    name            = string
    policy_path     = string
    terraform_roles = list(string)
    tf_state        = string
  }))
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "tf_plan_bucket" {
  description = "Name of bucket where tf_plan is sent from GitHub Actions"
  type        = string
}
