terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = local.aws_region

  default_tags {
    tags = local.tags
  }
}
