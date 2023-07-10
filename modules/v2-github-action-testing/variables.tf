variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "roles_can_assume_v2_github_action_testing_role" {
  description = "ARNs of the OpenID Connect Roles in the management account that can asssume v2-testing role"
  type        = list(string)
}

variable "v2_github_action_testing_policy_path" {
  description = "Path to the tre v2-testing role policy"
  type        = string
}
