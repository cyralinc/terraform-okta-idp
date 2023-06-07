variable "idp_integration_name" {
  type        = string
  description = "IdP integration name that will be shown in Control Plane."
}

variable "okta_groups" {
  type        = list(string)
  description = "Groups that will be assigned in the Okta Application."
  default     = []
}

variable "okta_app_name" {
  type        = string
  description = "The name of the Okta Application that will be created."
}

variable "okta_groups_filter" {
  type = object({
    type  = string
    value = string
  })
  description = "The type and value of the filter that will be applied to Okta groups."
  default = {
    type  = "REGEX"
    value = ".*"
  }
}
