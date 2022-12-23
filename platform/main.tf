module "terraform-plan-logs" {
  source = "../modules/terraform-plan-logs"
  prefix = var.prefix
}

module "codeartifact" {
  source = "../modules/codeartifact"
  prefix = var.prefix
}
