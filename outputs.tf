output "role_arns" {
  value = {
    for key, role in module.deployerRole :
    key => role.role_arn
  }
}

