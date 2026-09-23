locals {
  config_files = fileset("${path.module}/configs", "*.yaml")
  configs = { for file in local.config_files :
  file => yamldecode(file("${path.module}/configs/${file}")) }
}

module "deployerRole" {
  source         = "./modules/iam/role"
  for_each       = local.configs
  principal_type = each.value.principle_type
  role_name      = each.value.role_name
}
module "scoped_inline_policies" {
  source              = "./modules/iam/permissions"
  for_each            = local.configs
  services            = each.value.services
  arn-identifier-list = each.value.arn_ids
  role_name           = each.value.role_name
  depends_on          = [module.deployerRole]
}
