variable "tenant_name" {
  type = string
  description = "The tenant of your control plane. Ex.: mytenant"
}

variable "control_plane" {
  type = string
  description = "Control plane address. Ex.: mytenant.cyral.com"
}

variable "control_plane_port" {
  type = number
  description = "The port on which the control plane will be listening. Ex.: 8000"
  default = 8000
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

variable "assigned_users" {
 type = list(object(
   {
     id = string
     username = string
     password = string
   }
 )) 
 description = "People that will be assigned to the Cyral app on Okta."
 default = []
}

variable "okta_app_name" {
  type = string
  description = "The name of the app that will be created on okta."
}
