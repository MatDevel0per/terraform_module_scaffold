variable "role_name" {
  description = "The name of the IAM role to be created."
  type        = string
  default     = "deployer-role"
}

variable "environment" {
  description = "The environment your targeting"
  type        = string
  default     = "dev"
}
