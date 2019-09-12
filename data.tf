data "aws_iam_policy_document" "assume_role" {
  statement {
      effect = "Allow"
      actions = "sts:AssumeRoleWithWebIdentity"
      condition {
          test      = "StringEquals"
          variable  = "cognito-identity.amazonaws.com:aud"
          
          values = ["${aws_cognito_identity_pool.identity_pool.id}"]
      }
      principals {
          type = "Federated"
          identifiers = ["cognito-identity.amazonaws.com"]
      }
  }
}

data "aws_iam_policy_document" "unauthenticated_role" {
  statement {
      effect = "Allow"
      resources = ["*"]
      actions = [
        "mobileanalytics:PutEvents",
        "cognito-sync:*"
      ]
  }
}

data "aws_iam_policy_document" "authenticated_role" {
  statement {
      effect = "Allow"
      resources = ["*"]
      actions = [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ]
  }
}