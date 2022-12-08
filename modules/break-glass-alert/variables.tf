variable "tf_backend_role_arn" {
  description = "ARN of the tf-backend role"
  type = string
}

variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}
