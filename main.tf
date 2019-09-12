resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name                = "${var.namespace}IdentityPool"
  allow_unauthenticated_identities  = true
  cognito_identity_providers        {
      client_id     = "${var.client_id}"
      provider_name = "cognito-idp.${var.user_pool_region}.amazonaws.com/${var.user_pool_id}"
  }
 
}

resource "aws_cognito_identity_pool_roles_attachment" "unauthenticated_role" {
  identity_pool_id  = "${aws_cognito_identity_pool.identity_pool.id}"

  roles = {
      "authenticated"   = "${aws_iam_role.authenticated_role.arn}"
      "unauthenticated" = "${aws_iam_role.unauthenticated_role.arn}"
  }
}


resource "aws_iam_role" "unauthenticated_role" {
  name                  = "${var.namespace}-unauthenticated-role"
  assume_role_policy    = "${data.aws_iam_policy_document.assume_role.json}"
}

resource "aws_iam_role" "authenticated_role" {
  name                  = "${var.namespace}-authenticated-role"
  assume_role_policy    = "${data.aws_iam_policy_document.assume_role.json}"
}


resource "aws_iam_role_policy" "unauthenticated_policy" {
  name                  = "${var.namespace}-unauthenticated-policy"
  role                  = "${aws_iam_role.unauthenticated_role.id}"
  policy                = "${data.aws_iam_policy_document.unauthenticated_role.json}"
}

resource "aws_iam_role_policy" "authenticated_policy" {
  name                  = "${var.namespace}-authenticated-policy"
  role                  = "${aws_iam_role.authenticated_role.id}"
  policy                = "${data.aws_iam_policy_document.authenticated_role.json}"
}