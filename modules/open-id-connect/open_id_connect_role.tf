resource "aws_iam_role" "tre_github_actions_open_id_connect" {
  for_each           = { for role in var.tre_github_actions_open_id_connect_roles : role.name => role }
  name               = "${var.prefix}-github-actions-open-id-connect-role-${each.value.name}"
  assume_role_policy = data.aws_iam_policy_document.tre_github_actions_open_id_connect[each.key].json
}

data "aws_iam_policy_document" "tre_github_actions_open_id_connect" {
  for_each = { for role in var.tre_github_actions_open_id_connect_roles : role.name => role }
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.tre_github_actions.arn]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = each.value.tre_repositories
    }
  }
}

resource "aws_iam_policy" "tre_github_actions_open_id_connect" {
  for_each = { for policy in var.tre_github_actions_open_id_connect_policies : policy.name => policy }
  name     = "${var.prefix}-github-actions-open-id-connect-role-${each.value.name}"
  policy = templatefile(each.value.policy_path, {
    prefix          = var.prefix
    account_id      = var.account_id
    aws_region      = var.aws_region
    terraform_roles = each.value.terraform_roles
    tf_state        = each.value.tf_state
    tf_plan_bucket  = var.tf_plan_bucket
    v2_testing_roles = each.value.v2_testing_roles
  })
}

resource "aws_iam_role_policy_attachment" "tre_github_actions_open_id_connect" {
  for_each   = { for role in var.tre_github_actions_open_id_connect_roles : role.name => role }
  role       = aws_iam_role.tre_github_actions_open_id_connect[each.value.name].name
  policy_arn = aws_iam_policy.tre_github_actions_open_id_connect[each.value.name].arn
}
