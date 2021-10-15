terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.14"
    }
    cyral = {
      source = "cyralinc/cyral"
      version = ">= 2.0.1"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

provider "cyral" {
  # client_id and client_secret may also be declared as env vars.
  # Please see provider docs for more info.
  client_id = ""
  client_secret = ""

  control_plane = "mytenant.cyral.com:8000"
}

provider "okta" {
  org_name  = "your-organization-name"
  base_url  = "okta.com" # your organization base url
  api_token = ""
}

module "cyral_idp_okta" {
  source = "cyralinc/idp-okta/cyral"
  version = ">= 1.1.0"

  control_plane = "mytenant.cyral.com:8000"
  
  okta_app_name = "Cyral"
  okta_groups = ["Everyone"]

  integration_name = "Okta SSO"
}

output "integration_saml_okta_id" {
  value = module.cyral_idp_okta.integration_saml_okta_id
}

output "okta_app_saml_id" {
  value = module.cyral_idp_okta.okta_app_saml_id
}