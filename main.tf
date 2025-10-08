module "deployerRole" {
  source         = "./modules/iam/role"
  principal_type = "service"
  role_name      = var.role_name
}
module "scoped_inline_policies" {
  source              = "./modules/iam/permissions"
  services            = ["iam", "ec2", "ssm"]
  arn-identifier-list = ["devops", "analytics"]
  tag_key             = "Project"
  role_name           = module.deployerRole.role_name
}
