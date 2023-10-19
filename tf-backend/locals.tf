locals {
  tre_github_actions_open_id_connect_policies = [
    {
      name        = "tf-backend"
      policy_path = "./templates/open-id-connect-role-policy/tf_backend.tftpl"
      tf_state    = var.tf_state_platform
      roles_can_assume = [
        module.tre_prod_terraform_roles.tre_terraform_backend_role_arn,
        module.tre_nonprod_terraform_roles.tre_terraform_backend_role_arn,
        module.tre_management_terraform_roles.tre_terraform_backend_role_arn
      ]
    },
    {
      name        = "platform"
      policy_path = "./templates/open-id-connect-role-policy/platform.tftpl"
      tf_state    = var.tf_state_platform
      roles_can_assume = [
        module.tre_prod_terraform_roles.terraform_role_arn,
        module.tre_nonprod_terraform_roles.terraform_role_arn,
        module.tre_management_terraform_roles.terraform_role_arn
      ]
    },
    {
      name        = "nonprod"
      policy_path = "./templates/open-id-connect-role-policy/environments.tftpl"
      tf_state    = var.tf_state_environments
      roles_can_assume = [
        module.tre_nonprod_terraform_roles.terraform_role_arn
      ]
    },
    {
      name        = "prod"
      policy_path = "./templates/open-id-connect-role-policy/environments.tftpl"
      tf_state    = var.tf_state_environments
      roles_can_assume = [
        module.tre_prod_terraform_roles.terraform_role_arn
      ]
    },
    {
      name        = "v2-testing"
      policy_path = "./templates/open-id-connect-role-policy/v2-github-action-testing.tftpl"
      tf_state    = "" # Testing does not require any tf_state access
      roles_can_assume = [
        module.nonprod_v2_github_action_testing_roles.tre_v2_github_action_testing_role_arn,
        module.prod_v2_github_action_testing_roles.tre_v2_github_action_testing_role_arn
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
    },
    {
      name             = "v2-testing"
      tre_repositories = var.tre_testing_repositories
    }
  ]
}
