module "terraform-plan-logs" {
  source = "../modules/terraform-plan-logs"
  prefix = var.prefix
}

module "codeartifact" {
  source = "../modules/codeartifact"
  prefix = var.prefix
}

# Set up ECR replication to the non-prod and prod accounts; added for v2, but
# includes v1 replication as it is not currently possible to separate v1 and
# v2 replication with the AWS aws_ecr_replication_configuration Terraform
# resource.
module "ecr-replication" {
  source             = "../modules/ecr-replication"
  target_region      = data.aws_region.current.name
  account_id_nonprod = data.aws_caller_identity.nonprod.account_id
  account_id_prod    = data.aws_caller_identity.prod.account_id
}
