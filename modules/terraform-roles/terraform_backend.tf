resource "aws_iam_role" "tre_terraform_backend" {
  name               = "${var.prefix}-terraform-backend"
  assume_role_policy = data.aws_iam_policy_document.tre_assume_role_terraform_backend.json
}

resource "aws_iam_policy" "tre_terraform_backend" {
  name = "${var.prefix}-terraform-backend"
  policy = templatefile(var.terraform_backend_policy_path, {
    prefix                             = var.prefix
    account_id                         = var.account_id
  })
}

resource "aws_iam_role_policy_attachment" "tre_terraform_backend" {
  role       = aws_iam_role.tre_terraform_backend.name
  policy_arn = aws_iam_policy.tre_terraform_backend.arn
}
