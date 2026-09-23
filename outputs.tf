output "role_arn" {
  value = {
    for key, role in module.deployerRole :
    key => role.role_arn
  }
}

