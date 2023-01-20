locals {
  tre_github_actions_open_id_connect_policies = [
    {
      name        = "tf-backend"
      policy_path = "./templates/open-id-connect-role-policy/tf_backend_open_id_connect_role_policy.tftpl"
      tf_state    = var.tf_state_platform
      terraform_roles = [
        module.tre_prod_terraform_roles.tre_terraform_backend_role_arn,
        module.tre_nonprod_terraform_roles.tre_terraform_backend_role_arn,
        module.tre_users_terraform_roles.tre_terraform_backend_role_arn,
        module.tre_management_terraform_roles.tre_terraform_backend_role_arn,
      ]
    },
    {
      name        = "platform"
      policy_path = "./templates/open-id-connect-role-policy/platform_open_id_connect_role_policy.tftpl"
      tf_state    = var.tf_state_platform
      terraform_roles = [
        module.tre_prod_terraform_roles.terraform_role_arn,
        module.tre_nonprod_terraform_roles.terraform_role_arn,
        module.tre_users_terraform_roles.terraform_role_arn,
        module.tre_management_terraform_roles.terraform_role_arn,
      ]
    },
    {
      name        = "nonprod"
      policy_path = "./templates/open-id-connect-role-policy/env_open_id_connect_role_policy.tftpl"
      tf_state    = var.tf_state_environments
      terraform_roles = [
        module.tre_nonprod_terraform_roles.terraform_role_arn,
      ]
    },
    {
      name        = "prod"
      policy_path = "./templates/open-id-connect-role-policy/env_open_id_connect_role_policy.tftpl"
      tf_state    = var.tf_state_environments
      terraform_roles = [
        module.tre_prod_terraform_roles.terraform_role_arn
      ]
    }
  ]

  tre_github_actions_open_id_connect_roles = [
    {
      name             = "tf-backend"
      tre_repositories = var.tre_backend_repository
    },
    {
      name             = "platform"
      tre_repositories = var.tre_platform_repositories
    },
    {
      name             = "nonprod"
      tre_repositories = var.tre_nonprod_repositories
    },
    {
      name             = "prod"
      tre_repositories = var.tre_prod_repositories
    }
  ]
}
