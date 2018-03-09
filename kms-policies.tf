#######
# Policies
#######

## grats access to manage KMS
data "aws_iam_policy_document" "kms-policy-document-manage" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${var.AccountID}:role/${aws_iam_role.kms-manage.name}"]
  }
}

## policies for EC2/ECS to access  KMS
resource "aws_iam_policy" "STS-policy-KMS-manage" {
  name   = "STS-KMS-manage-${var.kms_alias_prefix}-${random_pet.random_pet.id}"
  policy = "${data.aws_iam_policy_document.kms-policy-document-manage.json}"
}

## grats access to Read KMS
data "aws_iam_policy_document" "kms-policy-document-read" {
  statement {
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::${var.AccountID}:role/${aws_iam_role.kms-read.name}"]
  }
}

## policies for EC2/ECS to access  KMS
resource "aws_iam_policy" "STS-policy-KMS-read" {
  name   = "STS-KMS-read-${var.kms_alias_prefix}-${random_pet.random_pet.id}"
  policy = "${data.aws_iam_policy_document.kms-policy-document-read.json}"
}
