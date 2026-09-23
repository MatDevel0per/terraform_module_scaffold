variable "principals" {
  description = "The principles allowed to assume the role"
  type = list(object({
    type        = string
    identifiers = list(string)
  }))
  nullable = false
}
variable "account_number" {
  description = "account number to allow in"
  type        = string
  default     = "0000000000"
}
variable "conditions" {
  description = <<EOT
  (OPTIONAL) Conditions for the roles assumption. 
  USAGE:
    operator = "IpAddress"
    key = "aws:SourceIp"
    value = "0.0.0.0/0"
  EOT
  type = list(object({
    operator = string
    key      = string
    value    = string
  }))
  default = []
}
# REFACTORING BELOW FOR MULTIPLE PRINICIPLE SUPPORT ;p
# variable "principal_type" {
#   description = "The type of principal (e.g., AWS, Service, Federated) for the IAM role."
#   type        = string
#   nullable    = false
#   validation {
#     condition     = length(trim(var.principal_type, " ")) > 0
#     error_message = "The principal_type variable must not be an empty string."
#   }
#   validation {
#     condition     = can(regex("^[^\\s]+$", var.principal_type))
#     error_message = "principal_type must not contain any whitespace (spaces, tabs, newlines, etc)."
#   }
# }
variable "role_name" {
  description = "The name of the IAM role to be created."
  type        = string
  nullable    = false
  validation {
    condition     = length(trim(var.role_name, " ")) > 0
    error_message = "The role_name variable must not be an empty string."
  }
  validation {
    condition     = can(regex("^[^\\s]+$", var.role_name))
    error_message = "role_name must not contain any whitespace (spaces, tabs, newlines, etc)."
  }
}
