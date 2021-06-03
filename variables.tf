variable "tenant" {
  type = string
  description = "The tenant of your control plane. Ex.: mytenant"
}

variable "control_plane" {
  type = string
  description = "Control plane address and port. Ex.: mytenant.cyral.com:8000"
}

variable "email_domains" {
  type = list(string)
  description = "Email domains that will be accepted as valid logins."
  default = []
}

variable "integration_name" {
  type = string
  description = "The name of the integration that will be created on cyral's control plane."
}

variable "assigned_groups" {
  type = list(string)
  description = "Groups that the cyral app will be assigned to on okta. These can be obtained from the \"okta_group\" data source."
  default = []
}

variable "okta_app_name" {
  type = string
  description = "The name of the app that will be created on okta."
}
