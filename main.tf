module "deployerRole" {
  source         = "./modules/iam/role"
  principal_type = "service"
  role_name      = var.role_name
}
module "scoped_inline_policies" {
  source     = "./modules/iam/permissions"
  services   = ["iam"]
  identifier = "devops"
  tag_key    = "Project"
  role_name  = module.deployerRole.role_name
}
