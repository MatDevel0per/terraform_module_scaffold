variable "services" {
  description = "List of service policy templates to include (e.g., [\"ec2\", \"iam\", \"ssm\"])."
  type        = list(string)
}


variable "identifier" {
  description = "Short code / identifier used to scope access (e.g., tag value, name fragment, or path component)."
  type        = string
}
variable "test-map" {
  description = "A test map variable."
  type        = map(string)
  default = {
    "Environment" = "prod"
    "Team"        = "devops"
  }
}

variable "tag_key" {
  description = "Tag key used on resources to bind them to the identifier."
  type        = string
  default     = "ShortCode"
}

variable "role_name" {
  description = "Name of the existing IAM role to attach inline policies to."
  type        = string
}


variable "max_policy_chars" {
  description = "Maximum JSON characters allowed per policy chunk. Conservative default to avoid IAM size limits."
  type        = number
  default     = 6000
}


variable "max_statements_per_policy" {
  description = "Safety cap on number of statements per chunk (secondary limiter)."
  type        = number
  default     = 25
}


variable "policy_name_prefix" {
  description = "Prefix for inline policy names."
  type        = string
  default     = "inline"
}
