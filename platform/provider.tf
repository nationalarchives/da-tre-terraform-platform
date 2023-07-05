provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn = var.assume_roles.mngmt
  }
  default_tags {
    tags = {
      Environment     = "platform"
      Owner           = "digital-archiving"
      Terraform       = true
      TerraformSource = "https://github.com/nationalarchives/da-tre-terraform-platform"
      CostCentre      = "56"
      Role            = "prvt"
    }
  }
}

provider "aws" {
  alias  = "nonprod"
  region = "eu-west-2"
  assume_role {
    role_arn = var.assume_roles.nonprod
  }
  default_tags {
    tags = {
      Environment     = "platform"
      Owner           = "digital-archiving"
      Terraform       = true
      TerraformSource = "https://github.com/nationalarchives/da-tre-terraform-platform"
      CostCentre      = "56"
      Role            = "prvt"
    }
  }
}

provider "aws" {
  alias  = "prod"
  region = "eu-west-2"
  assume_role {
    role_arn = var.assume_roles.prod
  }
  default_tags {
    tags = {
      Environment     = "platform"
      Owner           = "digital-archiving"
      Terraform       = true
      TerraformSource = "https://github.com/nationalarchives/da-tre-terraform-platform"
      CostCentre      = "56"
      Role            = "prvt"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
  }
}
