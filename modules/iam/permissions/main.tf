locals {
  rendered_templates = {
    for svc in var.services : svc => templatefile(
      "${path.module}/policies/${svc}.json.tmpl",
      {
        identifier = var.identifier
        tag_key    = var.tag_key
      }
    )
  }

  statements_by_service = [for s in var.services : jsondecode(local.rendered_templates[s]).Statement]
  all_statements = flatten([
    for stmts in local.statements_by_service : [
      for stmt in stmts : jsonencode(merge({}, stmt)) #Serialize each statement to JSON
    ]
  ])

  unified_policy_json = jsonencode({
    Version   = "2012-10-17"
    Statement = [for stmt in local.all_statements : jsondecode(stmt)] // Decode back for unified policy
  })

  total_len  = length(local.unified_policy_json)
  num_chunks = max(1, ceil(local.total_len / var.max_policy_chars))
  stmt_count = length(local.all_statements)
  chunk_size = max(1, min(var.max_statements_per_policy, ceil(local.stmt_count / local.num_chunks)))

  statement_chunks = chunklist(local.all_statements, local.chunk_size)

  policy_docs = [
    for chunk in local.statement_chunks : jsonencode({
      Version   = "2012-10-17"
      Statement = [for stmt in chunk : jsondecode(stmt)] // Decode back for each chunk
    })
  ]
}

# Create inline policies directly on an existing role
resource "aws_iam_role_policy" "inline" {
  count  = length(local.policy_docs)
  name   = "${var.policy_name_prefix}-${replace(var.identifier, ":/ \\*\"", "-")}-${count.index}"
  role   = var.role_name
  policy = local.policy_docs[count.index]
}
