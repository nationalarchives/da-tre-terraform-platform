module "tre_github_actions_open_id_connect" {
  source = "../modules/open-id-connect"
  prefix = var.prefix
  #   tre_repositories = var.tre_repositories
  tre_github_actions_open_id_connect_policies = local.tre_github_actions_open_id_connect_policies
  account_id                                  = data.aws_caller_identity.management.account_id
  aws_region                                  = data.aws_region.management.name
  tre_github_actions_open_id_connect_roles    = local.tre_github_actions_open_id_connect_roles
  tf_plan_bucket                              = var.tf_plan_bucket
}

# ----------------------------------------------------------

# TRE Environments Terraform Roles Modules
module "tre_management_terraform_roles" {
  source                                  = "../modules/terraform-roles"
  roles_can_assume_terraform_role         = concat([module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform], var.additional_roles_who_can_assume_terraform_roles)
  roles_can_assume_terraform_backend_role = concat([module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend], var.additional_roles_who_can_assume_terraform_roles)
  prefix                                  = var.prefix
  permission_boundary_policy_path         = "./templates/permission-boundary-policy/management.tftpl"
  terraform_policy_path                   = "./templates/terraform-role-policy/management.tftpl"
  terraform_iam_policy_path               = "./templates/terraform-iam-policy/management.tftpl"
  terraform_backend_policy_path           = "./templates/terraform-backend-role-policy/management.tftpl"
  tre_roles_managed_by_tf_backend         = local.tre_roles_managed_by_tf_backend_management
  tre_policies_managed_by_tf_backend      = local.tre_policies_managed_by_tf_backend_management
  account_id                              = data.aws_caller_identity.management.account_id
}

module "tre_nonprod_terraform_roles" {
  source = "../modules/terraform-roles"
  roles_can_assume_terraform_role = concat([
  module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform, module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.nonprod], var.additional_roles_who_can_assume_terraform_roles)
  roles_can_assume_terraform_backend_role = concat([module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend], var.additional_roles_who_can_assume_terraform_roles)
  prefix                                  = var.prefix
  permission_boundary_policy_path         = "./templates/permission-boundary-policy/environments.tftpl"
  terraform_policy_path                   = "./templates/terraform-role-policy/environments.tftpl"
  providers = {
    aws = aws.nonprod
  }
  terraform_iam_policy_path          = "./templates/terraform-iam-policy/environments.tftpl"
  terraform_backend_policy_path      = "./templates/terraform-backend-role-policy/environments.tftpl"
  tre_roles_managed_by_tf_backend    = local.tre_roles_managed_by_tf_backend_nonprod
  tre_policies_managed_by_tf_backend = local.tre_policies_managed_by_tf_backend_nonprod
  account_id                         = data.aws_caller_identity.nonprod.account_id
}

module "tre_prod_terraform_roles" {
  source = "../modules/terraform-roles"
  roles_can_assume_terraform_role = concat([
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.prod
  ], var.additional_roles_who_can_assume_terraform_roles)
  roles_can_assume_terraform_backend_role = concat([module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend], var.additional_roles_who_can_assume_terraform_roles)
  prefix                                  = var.prefix
  permission_boundary_policy_path         = "./templates/permission-boundary-policy/environments.tftpl"
  terraform_policy_path                   = "./templates/terraform-role-policy/environments.tftpl"
  providers = {
    aws = aws.prod
  }
  terraform_iam_policy_path          = "./templates/terraform-iam-policy/environments.tftpl"
  terraform_backend_policy_path      = "./templates/terraform-backend-role-policy/environments.tftpl"
  tre_roles_managed_by_tf_backend    = local.tre_roles_managed_by_tf_backend_prod
  tre_policies_managed_by_tf_backend = local.tre_policies_managed_by_tf_backend_prod
  account_id                         = data.aws_caller_identity.prod.account_id
}

# Roles grant access to GitHub action to execute tests
module "nonprod_v2_github_action_testing_roles" {
  source                                         = "../modules/v2-github-action-testing"
  prefix                                         = var.prefix
  aws_region                                     = data.aws_region.management.name
  account_id                                     = data.aws_caller_identity.nonprod.account_id
  roles_can_assume_v2_github_action_testing_role = [module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.v2-testing]
  v2_github_action_testing_policy_path           = "./templates/v2-github-action-testing-role-policy/nonprod.tftpl"
  providers = {
    aws = aws.nonprod
  }
}
