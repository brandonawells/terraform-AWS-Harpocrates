data "aws_iam_policy_document" "sts" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.IAMAccountID}:root"]
    }
  }
}

######
# KMS ROLES
######
resource "aws_iam_role" "kms-admin" {
  name               = "KMS-admin-${var.kms_alias_prefix}-${random_pet.random_pet.id}"
  assume_role_policy = "${data.aws_iam_policy_document.sts.json}"
}

resource "aws_iam_role" "kms-manage" {
  name               = "KMS-manage-${var.kms_alias_prefix}-${random_pet.random_pet.id}"
  assume_role_policy = "${data.aws_iam_policy_document.sts.json}"
}

resource "aws_iam_role_policy_attachment" "kms-manage-attach" {
  role       = "${aws_iam_role.kms-manage.name}"
  policy_arn = "${aws_iam_policy.STS-policy-KMS-manage.arn}"
}

resource "aws_iam_role" "kms-read" {
  name               = "KMS-read-${var.kms_alias_prefix}-${random_pet.random_pet.id}"
  assume_role_policy = "${data.aws_iam_policy_document.sts.json}"
}

resource "aws_iam_role_policy_attachment" "kms-read-attach" {
  role       = "${aws_iam_role.kms-read.name}"
  policy_arn = "${aws_iam_policy.STS-policy-KMS-read.arn}"
}

######
# SSM ROLES
######
resource "aws_iam_role" "ssm-read" {
  name               = "SSM-read-${var.ssm_prefix}-${random_pet.random_pet.id}"
  assume_role_policy = "${data.aws_iam_policy_document.sts.json}"
}

resource "aws_iam_role_policy_attachment" "ssm-read-role-attach" {
  role       = "${aws_iam_role.ssm-read.name}"
  policy_arn = "${aws_iam_policy.STS-policy-SSM-read.arn}"
}

resource "aws_iam_role" "ssm-manage" {
  name               = "SSM-manage-${var.ssm_prefix}-${random_pet.random_pet.id}"
  assume_role_policy = "${data.aws_iam_policy_document.sts.json}"
}

resource "aws_iam_role_policy_attachment" "ssm-manage-role-attach" {
  role       = "${aws_iam_role.ssm-manage.name}"
  policy_arn = "${aws_iam_policy.STS-policy-SSM-manage.arn}"
}

######
# ECS ROLES
######
data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-service-read-role" {
  name               = "ecs-service-ssm-read-${var.kms_alias_prefix}-${random_pet.random_pet.id}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ecs-service-policy.json}"
}

resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role       = "${aws_iam_role.ecs-service-read-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

######
# EC2 ROLES
######
data "aws_iam_policy_document" "ec2-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2-read-role" {
  name               = "ec2-ssm-read-${var.kms_alias_prefix}-${random_pet.random_pet.id}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-policy.json}"
}
