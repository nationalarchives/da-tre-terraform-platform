variable "target_account_id" {
  description = "The AWS account to replicate to"
  type        = string
}

variable "target_region" {
  description = "The AWS region to replicate to"
  type        = string
}

variable "filter" {
  description = "Replicate repositories that match this filter"
  type = string
}
