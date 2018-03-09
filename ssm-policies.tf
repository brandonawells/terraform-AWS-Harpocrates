# # https://aws.amazon.com/blogs/compute/managing-secrets-for-amazon-ecs-applications-using-parameter-store-and-iam-roles-for-tasks/
# https://docs.aws.amazon.com/kms/latest/developerguide/iam-policies.html

data "aws_iam_policy_document" "ssm-read-policy-document" {
  statement {
    sid = "SSMDescribeParameters"

    actions = [
      "ssm:DescribeParameters",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "SSMGetParameters"

    actions = [
      "ssm:GetParameters",
    ]

    resources = [
      "arn:aws:ssm:${var.region}:${var.AccountID}:parameter/${var.ssm_prefix}*",
    ]
  }

  statement {
    sid = "KMSDecrypt"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "${aws_kms_key.kms-key.arn}",
    ]
  }
}

resource "aws_iam_policy" "STS-policy-SSM-read" {
  name   = "STS-SSM-read-${var.ssm_prefix}-${random_pet.random_pet.id}"
  policy = "${data.aws_iam_policy_document.ssm-read-policy-document.json}"
}

data "aws_iam_policy_document" "ssm-manage-policy-document" {
  statement {
    sid = "SSMDescribeParameters"

    actions = [
      "ssm:DescribeParameters",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "SSMSetParameters"

    actions = [
      "ssm:GetParameters",
      "ssm:PutParameter",
      "ssm:DeleteParameter",
      "ssm:DeleteParameters",
    ]

    resources = [
      "arn:aws:ssm:${var.region}:${var.AccountID}:parameter/${var.ssm_prefix}*",
    ]
  }

  statement {
    sid = "KMSEncrypt"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
    ]

    resources = [
      "${aws_kms_key.kms-key.arn}",
    ]
  }
}

resource "aws_iam_policy" "STS-policy-SSM-manage" {
  name   = "STS-SSM-manage-${var.ssm_prefix}-${random_pet.random_pet.id}"
  policy = "${data.aws_iam_policy_document.ssm-manage-policy-document.json}"
}
