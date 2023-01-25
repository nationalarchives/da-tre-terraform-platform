data "aws_caller_identity" "management" {
  provider = aws
}

data "aws_region" "management" {
  provider = aws
}

data "aws_caller_identity" "users" {
  provider = aws.users
}

data "aws_region" "users" {
  provider = aws.users
}

data "aws_caller_identity" "nonprod" {
  provider = aws.nonprod
}

data "aws_region" "nonprod" {
  provider = aws.nonprod
}

data "aws_caller_identity" "prod" {
  provider = aws.prod
}

data "aws_region" "prod" {
  provider = aws.prod
}
