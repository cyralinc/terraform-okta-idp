provider "cyral" {
  # client_id and client_secret may also be declared as env vars.
  # Please see provider docs for more info.
  client_id     = ""
  client_secret = ""

  control_plane = "mytenant.cyral.com"
}

provider "okta" {
  org_name  = "your-organization-name"
  base_url  = "okta.com" # your organization url
  api_token = ""
}

module "cyral_idp_okta" {
  source  = "cyralinc/idp/okta"
  version = ">= 3.0.0"

  okta_app_name = "Cyral"
  okta_groups   = ["Everyone"]
  okta_groups_filter = {
    type  = "REGEX"
    value = "(Dev)|(Admin)"
  }

  idp_integration_name = "Okta"
}
