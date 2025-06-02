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

variable "account_id" {
  type        = string
  default     = "{add me in your .auto.tfvars file}"
  description = "AWS account id"
}

variable "github_organisation" {
  type        = string
  default     = "{add me in your .auto.tfvars file}"
  description = "GitHub source organisation (to allow to assume role from)"
}

variable "github_repo" {
  type        = string
  default     = "{add me in your .auto.tfvars file}"
  description = "GitHub organisation repo (to allow to assume role from)"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com"
  ]
}

data "aws_iam_policy_document" "github_role_policy_document" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_organisation}/${var.github_repo}:*"]
    }
  }
}

resource "aws_iam_role" "github_action_role" {
  name               = "GitHubAction_AssumeInfrastructureManagementRole"
  assume_role_policy = data.aws_iam_policy_document.github_role_policy_document.json

  tags = {
    Author = "Reuben"
  }
}
