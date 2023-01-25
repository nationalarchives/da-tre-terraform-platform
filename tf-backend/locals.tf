locals {
  tre_github_actions_open_id_connect_policies = [
    {
      name        = "tf-backend"
      policy_path = "./templates/open-id-connect-role-policy/tf_backend.tftpl"
      tf_state    = var.tf_state_platform
      terraform_roles = [
        module.tre_prod_terraform_roles.tre_terraform_backend_role_arn,
        module.tre_nonprod_terraform_roles.tre_terraform_backend_role_arn,
        module.tre_management_terraform_roles.tre_terraform_backend_role_arn
      ]
    },
    {
      name        = "platform"
      policy_path = "./templates/open-id-connect-role-policy/platform.tftpl"
      tf_state    = var.tf_state_platform
      terraform_roles = [
        module.tre_prod_terraform_roles.terraform_role_arn,
        module.tre_nonprod_terraform_roles.terraform_role_arn,
        module.tre_management_terraform_roles.terraform_role_arn
      ]
    },
    {
      name        = "nonprod"
      policy_path = "./templates/open-id-connect-role-policy/environments.tftpl"
      tf_state    = var.tf_state_environments
      terraform_roles = [
        module.tre_nonprod_terraform_roles.terraform_role_arn
      ]
    },
    {
      name        = "prod"
      policy_path = "./templates/open-id-connect-role-policy/environments.tftpl"
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

  tre_roles_managed_by_tf_backend_management = [
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.nonprod,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.prod,
    module.tre_management_terraform_roles.tre_terraform_backend_role_arn,
    module.tre_management_terraform_roles.terraform_role_arn
  ]

  tre_policies_managed_by_tf_backend_management = [
    module.tre_github_actions_open_id_connect.tre_open_id_connect_policies.platform,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_policies.tf-backend,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_policies.nonprod,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_policies.prod,
    module.tre_management_terraform_roles.tre_terraform_iam_policy,
    module.tre_management_terraform_roles.tre_terraform_policy,
    module.tre_management_terraform_roles.tre_permission_boundary,
    "arn:aws:iam::${data.aws_caller_identity.management.account_id}:policy/${var.prefix}-terraform-backend"
  ]

  tre_roles_managed_by_tf_backend_nonprod = [
    module.tre_nonprod_terraform_roles.tre_terraform_backend_role_arn,
    module.tre_nonprod_terraform_roles.terraform_role_arn
  ]

  tre_policies_managed_by_tf_backend_nonprod = [
    module.tre_nonprod_terraform_roles.tre_terraform_iam_policy,
    module.tre_nonprod_terraform_roles.tre_terraform_policy,
    module.tre_nonprod_terraform_roles.tre_permission_boundary,
    "arn:aws:iam::${data.aws_caller_identity.nonprod.account_id}:policy/${var.prefix}-terraform-backend"
  ]

  tre_roles_managed_by_tf_backend_prod = [
    module.tre_prod_terraform_roles.tre_terraform_backend_role_arn,
    module.tre_prod_terraform_roles.terraform_role_arn
  ]

  tre_policies_managed_by_tf_backend_prod = [
    module.tre_prod_terraform_roles.tre_terraform_iam_policy,
    module.tre_prod_terraform_roles.tre_terraform_policy,
    module.tre_prod_terraform_roles.tre_permission_boundary,
    "arn:aws:iam::${data.aws_caller_identity.prod.account_id}:policy/${var.prefix}-terraform-backend"
  ]
}
