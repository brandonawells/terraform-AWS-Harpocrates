output "random_pet_kms_key" {
  value = "${random_pet.random_pet.id}"
}

output "aws_kms_alias_name" {
  value = "${aws_kms_alias.kms-key-alias.name}"
}

output "aws_kms_alias_arn" {
  value = "${aws_kms_alias.kms-key-alias.arn}"
}

output "aws_kms_arn" {
  value = "${aws_kms_key.kms-key.arn}"
}

output "role_kms_admin_arn" {
  value = "${aws_iam_role.kms-admin.arn}"
}

output "role_kms_admin_name" {
  value = "${aws_iam_role.kms-admin.name}"
}

output "role_kms_manage_arn" {
  value = "${aws_iam_role.kms-manage.arn}"
}

output "role_kms_manage_name" {
  value = "${aws_iam_role.kms-manage.name}"
}

output "role_kms_read_arn" {
  value = "${aws_iam_role.kms-read.arn}"
}

output "role_kms_read_name" {
  value = "${aws_iam_role.kms-read.name}"
}

output "role_ssm_read_arn" {
  value = "${aws_iam_role.ssm-read.arn}"
}

output "role_ssm_read_name" {
  value = "${aws_iam_role.ssm-read.name}"
}

output "role_ssm_manage_arn" {
  value = "${aws_iam_role.ssm-manage.arn}"
}

output "role_ssm_manage_name" {
  value = "${aws_iam_role.ssm-manage.name}"
}

output "role_ecs_service_read_arn" {
  value = "${aws_iam_role.ecs-service-read-role.arn}"
}

output "role_ecs_service_read_name" {
  value = "${aws_iam_role.ecs-service-read-role.name}"
}

output "role_ec2_read_arn" {
  value = "${aws_iam_role.ec2-read-role.arn}"
}

output "role_ec2_read_name" {
  value = "${aws_iam_role.ec2-read-role.name}"
}

output "aws_iam_kms_policy_name" {
  value = "${aws_iam_policy.STS-policy-KMS-manage.name}"
}

output "aws_iam_kms_policy_arn" {
  value = "${aws_iam_policy.STS-policy-KMS-manage.arn}"
}

output "aws_iam_ssm_read_policy_name" {
  value = "${aws_iam_policy.STS-policy-SSM-read.name}"
}

output "aws_iam_ssm_read_policy_arn" {
  value = "${aws_iam_policy.STS-policy-SSM-read.arn}"
}

output "aws_iam_ssm_manage_policy_name" {
  value = "${aws_iam_policy.STS-policy-SSM-manage.name}"
}

output "aws_iam_ssm_manage_policy_arn" {
  value = "${aws_iam_policy.STS-policy-SSM-manage.arn}"
}
