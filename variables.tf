variable "control_plane" {
  type = string
  description = "Control plane host and API port (ex: some-cp.cyral.com:8000)"
}

variable "tenant" {
  type = string
  description = "Tenant associated with the control plane"
  default = "default"
}

variable "okta_app_name" {
  type = string
  description = "The name of the app that will be created in Okta."
}

variable "okta_groups" {
  type = list(string)
  description = "Groups that the cyral app will be assigned to in Okta."
  default = []
}

variable "integration_name" {
  type = string
  description = "Integration name that will be shown in Control Plane."
}
