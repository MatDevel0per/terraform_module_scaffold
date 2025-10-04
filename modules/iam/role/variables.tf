variable "principal_type" {
  description = "The type of principal (e.g., AWS, Service, Federated) for the IAM role."
  type        = string
  nullable    = false
  validation {
    condition     = length(trim(var.principal_type, " ")) > 0
    error_message = "The principal_type variable must not be an empty string."
  }
}
variable "role_name" {
  description = "The name of the IAM role to be created."
  type        = string
  nullable    = false
  validation {
    condition     = length(trim(var.role_name, " ")) > 0
    error_message = "The role_name variable must not be an empty string."
  }
}
