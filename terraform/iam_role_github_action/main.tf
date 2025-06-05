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