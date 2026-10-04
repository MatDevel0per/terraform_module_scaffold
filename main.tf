locals {
  config_files = fileset("${path.module}/configs", "*.yaml")
  configs = { for file in local.config_files :
  file => yamldecode(file("${path.module}/configs/${file}")) }
  parameter_files = fileset("${path.module}/configs/parameters", "*.yaml")
  parameter_configs = { for file in local.parameter_files :
  file => yamldecode(file("${path.module}/configs/parameters/${file}")) }
  parameters = flatten([
    for config in local.parameter_configs :
    config.parameters
  ])
  parameters_by_name = {
    for parameter in local.parameters :
    parameter.name => parameter
  }
  environment = "dev"
}

module "deployerRole" {
  source     = "./modules/iam/role"
  for_each   = local.configs
  principals = try(var.environment == "dev" ? each.value.dev_principals : each.value.prod_principles)
  role_name  = each.value.role_name
}
module "scoped_inline_policies" {
  source              = "./modules/iam/permissions"
  for_each            = local.configs
  services            = each.value.services
  arn-identifier-list = each.value.arn_ids
  role_name           = each.value.role_name
  depends_on          = [module.deployerRole]
}

resource "aws_ssm_parameter" "parameter" {
  for_each = local.parameters_by_name
  name     = "/${each.key}"
  type     = each.value.type
  # change to variable in actual implementation
  value       = coalesce(try(each.value.values[local.environment], null), try(each.value.values["default"], null), "PLACEHOLDER")
  description = each.value.description
}
