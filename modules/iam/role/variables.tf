variable "principal_type" {
  description = "The type of principal (e.g., AWS, Service, Federated) for the IAM role."
  type        = string
  nullable    = false
}
variable "role_name" {
  description = "The name of the IAM role to be created."
  type        = string
  nullable    = false
}
