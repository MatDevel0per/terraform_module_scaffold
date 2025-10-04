module "deployerRole" {
  source         = "./modules/iam/role"
  principal_type = "service"
  role_name      = var.role_name
}
