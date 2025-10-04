locals {
  create_role = var.principal_type != "" && var.role_name != "" ? true : false
}
data "aws_iam_policy_document" "role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.principal_type
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  count              = local.create_role ? 1 : 0
  name               = var.role_name
  path               = "/deployment/"
  assume_role_policy = data.aws_iam_policy_document.role_policy.json
}
