provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn    = var.assume_roles.mngmt
    external_id = var.external_id
  }
  default_tags {
    tags = {
      Environment     = "platform"
      Owner           = "digital-archiving"
      Terraform       = true
      TerraformSource = "https://github.com/nationalarchives/tre-terraform-platform"
      CostCentre      = "56"
      Role            = "prvt"
    }
  }
}

provider "aws" {
  alias  = "users"
  region = "eu-west-2"
  assume_role {
    role_arn    = var.assume_roles.users
    external_id = var.external_id
  }
  default_tags {
    tags = {
      Environment     = "platform"
      Owner           = "digital-archiving"
      Terraform       = true
      TerraformSource = "https://github.com/nationalarchives/tre-terraform-platform"
      CostCentre      = "56"
      Role            = "prvt"
    }
  }
}

provider "aws" {
  alias  = "nonprod"
  region = "eu-west-2"
  assume_role {
    role_arn    = var.assume_roles.nonprod
    external_id = var.external_id
  }
  default_tags {
    tags = {
      Environment     = "platform"
      Owner           = "digital-archiving"
      Terraform       = true
      TerraformSource = "https://github.com/nationalarchives/tre-terraform-platform"
      CostCentre      = "56"
      Role            = "prvt"
    }
  }  
}

provider "aws" {
  alias  = "prod"
  region = "eu-west-2"
  assume_role {
    role_arn    = var.assume_roles.prod
    external_id = var.external_id
  }
  default_tags {
    tags = {
      Environment     = "platform"
      Owner           = "digital-archiving"
      Terraform       = true
      TerraformSource = "https://github.com/nationalarchives/tre-terraform-platform"
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
