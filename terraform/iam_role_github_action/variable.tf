variable "account_id" {
  type        = string
  default     = "{add me in your .auto.tfvars file}"
  description = "AWS account id"
}

variable "github_organisation" {
  type        = string
  default     = "{add me in your .auto.tfvars file}"
  description = "GitHub source organisation (to allow to assume role from)"
}

variable "github_repo" {
  type        = string
  default     = "{add me in your .auto.tfvars file}"
  description = "GitHub organisation repo (to allow to assume role from)"
}

variable "policy_name" {
  type        = string
  default     = "{add me in your .auto.tfvars file}"
  description = "IAM policy name to apply to the new role"
}