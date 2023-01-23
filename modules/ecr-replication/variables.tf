variable "target_region" {
  description = "The AWS region to replicate to"
  type        = string
}

variable "account_id_nonprod" {
  description = "The ID of the non-prod TRE AWS account to replicate to"
  type        = string
}

variable "account_id_prod" {
  description = "The ID of the non-prod TRE AWS account to replicate to"
  type        = string
}
