resource "aws_iam_role" "tna_admin_role" {
  name               = "IAM_Admin_Role"
  assume_role_policy = data.aws_iam_policy_document.admin_role_policy.json
}

resource "aws_iam_role_policy_attachment" "attach_managed_admin_policy" {
  role       = aws_iam_role.tna_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
