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
  source = "cyralinc/idp/okta"
  version = ">= 3.0.0"

  control_plane = "mytenant.cyral.com:8000"
  
  okta_app_name = "Cyral"
  
  idp_integration_name = "Okta"
}
