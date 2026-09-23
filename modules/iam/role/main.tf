locals {
  create_role = var.role_name != "" ? true : false
}

resource "aws_iam_role" "role" {
  count = local.create_role ? 1 : 0
  name  = var.role_name
  path  = "/deployment/"
  assume_role_policy = templatefile(
    "${path.module}/policies/trust-relationship.json.tmpl",
    {
      principals    = var.principals
      accountNumber = var.account_number
      conditions    = var.conditions
    }
  )
}
