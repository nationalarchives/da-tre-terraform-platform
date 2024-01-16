variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}

variable "assume_roles" {
  description = "role ARNs to be assumed"
  type = object({
    mngmt   = string
    nonprod = string
    prod    = string
  })
}

variable "tre_backend_repository" {
  description = "TRE platform repository that requires access to TRE AWS accounts to make changes to Terraform backend"
  type        = list(string)
}

variable "tre_platform_repositories" {
  description = "List of TRE repositories that require access to tre AWS Management Account"
  type        = list(string)
}

variable "tre_prod_repositories" {
  description = "List of TRE repositories that require access to tre AWS prod account"
  type        = list(string)
}

variable "tre_nonprod_repositories" {
  description = "List of TRE repositories that require access to tre AWS nonprod account"
  type        = list(string)
}

variable "tre_testing_repositories" {
  description = "List of TRE repositories that can access the testing role"
  type        = list(string)
}

variable "tf_plan_bucket" {
  description = "Name of bucket where tf_plan is sent from GitHub Actions"
  type        = string
}

variable "tf_state_platform" {
  description = "Terraform state name for platform"
  type        = string
}

variable "tf_state_environments" {
  description = "Terraform state name for environments"
  type        = string
}

variable "additional_roles_who_can_assume_terraform_roles" {
  description = "List of ARNs of principles who can assume the tre-terraform and tre-terraform-backend roles beyond Github"
  type        = list(string)
}

variable "tna_admin_account_arn" {
  description = "arn of TNA cross organisation admin account"
  type        = string
}
