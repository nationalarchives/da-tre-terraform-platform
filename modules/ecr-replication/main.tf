locals {
  tre_v2_ecr_replication_filter_v1 = "lambda_functions/"
  tre_v2_ecr_replication_filter_v2 = "tre-v2/"
  ecr_replication_filter_type      = "PREFIX_MATCH"
}

# Replicate TRE ECR images from the management account to non-prod and prod
resource "aws_ecr_replication_configuration" "tre" {
  replication_configuration {
    # Replicate v1 TRE images to non-prod account
    rule {
      destination {
        region      = var.target_region
        registry_id = var.account_id_nonprod
      }

      repository_filter {
        filter      = local.tre_v2_ecr_replication_filter_v1
        filter_type = local.ecr_replication_filter_type
      }
    }

    # Replicate v1 TRE images to prod account
    rule {
      destination {
        region      = var.target_region
        registry_id = var.account_id_prod
      }

      repository_filter {
        filter      = local.tre_v2_ecr_replication_filter_v1
        filter_type = local.ecr_replication_filter_type
      }
    }

    # Replicate v2 TRE images to non-prod account
    rule {
      destination {
        region      = var.target_region
        registry_id = var.account_id_nonprod
      }

      repository_filter {
        filter      = local.tre_v2_ecr_replication_filter_v2
        filter_type = local.ecr_replication_filter_type
      }
    }

    # Replicate v2 TRE images to prod account
    rule {
      destination {
        region      = var.target_region
        registry_id = var.account_id_prod
      }

      repository_filter {
        filter      = local.tre_v2_ecr_replication_filter_v2
        filter_type = local.ecr_replication_filter_type
      }
    }
  }
}
