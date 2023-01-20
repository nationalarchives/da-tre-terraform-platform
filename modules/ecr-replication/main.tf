# Set up ECR replication to given account for given filter
resource "aws_ecr_replication_configuration" "non-prod" {
  replication_configuration {
    rule {
      destination {
        region = var.target_region
        registry_id = var.target_account_id
      }

      repository_filter {
        filter = var.filter
        filter_type = "PREFIX_MATCH"
      }
    }
  }
}
