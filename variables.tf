variable "tenant" {
  type = string
  description = "Tenant associated with the control plane"
}

variable "control_plane" {
  type = string
  description = "Control plane host and API port (ex: some-cp.cyral.com:8000)"
}

variable "email_domains" {
  type = list(string)
  description = "Email domains that will be accepted as valid logins."
  default = []
}

variable "integration_name" {
  type = string
  description = "Integration name that will be shown in Control Plane."
}

variable "okta_groups" {
  type = list(string)
  description = "Groups that the cyral app will be assigned to in Okta."
  default = []
}

variable "okta_app_name" {
  type = string
  description = "The name of the app that will be created in Okta."
}
