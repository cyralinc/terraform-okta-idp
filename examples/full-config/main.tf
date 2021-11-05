provider "cyral" {
  # client_id and client_secret may also be declared as env vars.
  # Please see provider docs for more info.
  client_id = ""
  client_secret = ""

  control_plane = "mytenant.cyral.com:8000"
}

provider "okta" {
  org_name  = "your-organization-name"
  base_url  = "okta.com" # your organization url
  api_token = ""
}

module "cyral_idp_okta" {
  source = "cyralinc/idp-okta/cyral"
  version = ">= 2.0.0"

  control_plane = "mytenant.cyral.com:8000"
  tenant = "default"
  
  okta_app_name = "Cyral"
  okta_groups = ["Everyone"]

  idp_integration_name = "Okta"
  back_channel_logout = false
  wants_assertions_encrypted = false
  disable_force_authentication = true
  allowed_clock_skew = 0
}
