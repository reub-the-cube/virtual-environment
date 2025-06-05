terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

# This can only exist once per account
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    ProtectFromNuke = "true"
  }
}

resource "aws_iam_role" "github_action_role" {
  name               = "GitHubAction_AssumeRole_${var.github_organisation}_${var.github_repo}"
  assume_role_policy = data.aws_iam_policy_document.github_role_policy_document.json

  tags = {
    Author = "Reuben"
  }
}

resource "aws_iam_role_policy_attachment" "github_role_admin_policy_attach" {
  role       = aws_iam_role.github_action_role.name
  policy_arn = data.aws_iam_policy.admin_access_policy.arn
}