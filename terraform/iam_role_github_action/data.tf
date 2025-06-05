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

data "aws_iam_policy" "admin_access_policy" {
  name = var.policy_name
}
