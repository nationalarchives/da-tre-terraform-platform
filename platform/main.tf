module "terraform-plan-logs" {
  source = "../modules/terraform-plan-logs"
  prefix = var.prefix
}

module "codeartifact" {
  source = "../modules/codeartifact"
  prefix = var.prefix
}

locals {
  # ECR replication filter string (a local as used in more than one place)
  tre_v2_ecr_replication_filter = "tre-v2/"
}

# Set up ECR replication of TRE v2 images to the non-prod account
module "ecr-replication-nonprod" {
  source            = "../modules/ecr-replication"
  target_account_id = data.aws_caller_identity.nonprod.account_id
  target_region     = data.aws_region.current.name
  filter            = local.tre_v2_ecr_replication_filter
}

# Set up ecr-replication of TRE v2 images to the prod account
module "ecr-replication-prod" {
  source            = "../modules/ecr-replication"
  target_account_id = data.aws_caller_identity.prod.account_id
  target_region     = data.aws_region.current.name
  filter            = local.tre_v2_ecr_replication_filter
}
