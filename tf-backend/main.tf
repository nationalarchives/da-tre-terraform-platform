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
  external_id                             = var.external_id
  roles_can_assume_terraform_role         = [module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform]
  roles_can_assume_terraform_backend_role = [module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend]
  prefix                                  = var.prefix
  permission_boundary_policy_path         = "./templates/permission-boundary-policy/management.tftpl"
  terraform_policy_path                   = "./templates/terraform-role-policy/management.tftpl"
  terraform_iam_policy_path               = "./templates/terraform-iam-policy/management.tftpl"
  terraform_backend_policy_path           = "./templates/terraform-backend-role-policy/management.tftpl"
  tre_roles_managed_by_tf_backend         = local.tre_roles_managed_by_tf_backend_management
  tre_policies_managed_by_tf_backend      = local.tre_policies_managed_by_tf_backend_management
  account_id                              = data.aws_caller_identity.management.account_id
}

module "tre_users_terraform_roles" {
  source                                  = "../modules/terraform-roles"
  external_id                             = var.external_id
  roles_can_assume_terraform_role         = [module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform]
  roles_can_assume_terraform_backend_role = [module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend]
  prefix                                  = var.prefix
  permission_boundary_policy_path         = "./templates/permission-boundary-policy/users.tftpl"
  terraform_policy_path                   = "./templates/terraform-role-policy/users.tftpl"
  providers = {
    aws = aws.users
  }
  terraform_iam_policy_path          = "./templates/terraform-iam-policy/users.tftpl"
  terraform_backend_policy_path      = "./templates/terraform-backend-role-policy/users.tftpl"
  tre_policies_managed_by_tf_backend = []
  tre_roles_managed_by_tf_backend    = []
  account_id                         = data.aws_caller_identity.users.account_id
}

module "tre_nonprod_terraform_roles" {
  source      = "../modules/terraform-roles"
  external_id = var.external_id
  roles_can_assume_terraform_role = [
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.nonprod
  ]
  roles_can_assume_terraform_backend_role = [module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend]
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
  source      = "../modules/terraform-roles"
  external_id = var.external_id
  roles_can_assume_terraform_role = [
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform,
    module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.prod
  ]
  roles_can_assume_terraform_backend_role = [module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.tf-backend]
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
