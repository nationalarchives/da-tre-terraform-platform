# Provide access to the current AWS region (e.g. data.aws_region.current.name)
data "aws_region" "current" {}

# Provide access to the nonprod account details (e.g. data.aws_caller_identity.nonprod.account_id)
data "aws_caller_identity" "nonprod" {
  provider = aws.nonprod
}

# Provide access to the prod account details (e.g. data.aws_caller_identity.prod.account_id)
data "aws_caller_identity" "prod" {
  provider = aws.prod
}

data "aws_caller_identity" "aws" {
  provider = aws
}