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

module "cyral_sso_okta" {
  source = "cyralinc/sso-okta/cyral"
  version = ">= 2.0.0"

  control_plane = "mytenant.cyral.com:8000"
  
  okta_app_name = "Cyral"
  
  sso_integration_name = "Okta SSO"
}
