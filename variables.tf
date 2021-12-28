variable "tenant" {
  type = string
  description = "Tenant associated with the Control Plane."
  default = "default"
}

variable "control_plane" {
  type = string
  description = "Control plane host and API port (ex: some-cp.cyral.com:8000)."
}

variable "idp_integration_name" {
  type = string
  description = "IdP integration name that will be shown in Control Plane."
}

variable "back_channel_logout" {
  type = bool
  description = "Indicates whether or not the Okta Identity Provider supports backchannel logout."
  default = null
}

variable "wants_assertions_encrypted" {
  type = bool
  description = "Indicates whether the Cyral Service Provider expects an encrypted assertion."
  default = null
}

variable "disable_force_authentication" {
  type = bool
  description = "Indicates whether the Okta Identity Provider must authenticate the presenter directly rather than rely on a previous security context."
  default = null
}

variable "allowed_clock_skew" {
  type = number
  description = "Clock skew in seconds that is tolerated when validating Identity Provider tokens."
  default = null
}

variable "okta_groups" {
  type = list(string)
  description = "Groups that will be assigned in the Okta Application."
  default = []
}

variable "okta_app_name" {
  type = string
  description = "The name of the Okta Application that will be created."
}

variable "okta_groups_filter" {
  type = object({
    type = string
    value = string
  })
  description = "The type and value of the filter that will be applied to Okta groups."
  default = {
    type = "REGEX"
    value = ".*"
  }
}
