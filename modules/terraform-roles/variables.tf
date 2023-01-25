variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}

variable "roles_can_assume_terraform_role" {
  description = "ARNs of the OpenID Connect Roles in the management account that can asssume terraform role"
  type        = list(string)
}

variable "roles_can_assume_terraform_backend_role" {
  description = "ARNs of the OpenID Connect Platform Role in the management account that can asssume terraform backend role"
  type        = list(string)
}


variable "permission_boundary_policy_path" {
  description = "Path to the tre permission boundary policy"
  type        = string
}

variable "terraform_policy_path" {
  description = "Path to the tre terraform role policy"
  type        = string
}

variable "terraform_iam_policy_path" {
  description = "Path to the tre terraform role iam policy"
  type        = string
}

variable "terraform_backend_policy_path" {
  description = "Path to the tre terraform backend policy"
  type        = any
}

variable "tre_roles_managed_by_tf_backend" {
  description = "ARNs of the roles managed by tre-terraform-backend"
  type        = list(string)
}

variable "tre_policies_managed_by_tf_backend" {
  description = "ARNs of the policies managed by tre-terraform-backend"
  type        = list(string)
}
variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "external_id" {
  description = "Zaizi external ID for role assumption"
  type        = string
}
