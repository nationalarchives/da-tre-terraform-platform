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
