locals {
  create_role = var.role_name != "" ? true : false
}
data "aws_iam_policy_document" "trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    dynamic "principals" {
      for_each = var.principals

      content {
        type = principals.value.type
        identifiers = [
          for identifier in principals.value.identifiers :
          principals.value.type == "AWS" && !startswith(identifier, "arn:") ?
          "arn:aws:iam::${var.account_number}:role/${identifier}" :
          identifier
        ]
      }
    }
    dynamic "condition" {
      for_each = var.conditions

      content {
        test     = condition.value.operator
        variable = condition.value.key
        values   = [condition.value.value]
      }
    }
  }
}

resource "aws_iam_role" "role" {
  count              = local.create_role ? 1 : 0
  name               = var.role_name
  path               = "/deployment/"
  assume_role_policy = data.aws_iam_policy_document.trust.json
  # assume_role_policy = templatefile(
  #   "${path.module}/policies/trust-relationship.json.tmpl",
  #   {
  #     principals    = var.principals
  #     accountNumber = var.account_number
  #     conditions    = var.conditions
  #   }
  # )
}
