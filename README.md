# Cyral IdP Integration Module for Okta

This module provides the complete configuration to integrate Okta as an Identity Provider to Cyral Control Plane. It applies an equivalent configuration as described in the [Cyral documentation for Okta SSO](https://cyral.com/docs/sso-okta).

## Usage

```terraform
provider "cyral" {
  control_plane = "mytenant.cyral.com:8000"
}

provider "okta" {
  org_name  = "your-organization-name"
  base_url  = "okta.com" # your organization url
  api_token = "your-api-token"
}

module "cyral-idp-okta" {
  source = "cyral/idp-okta"

  control_plane = "mytenant.cyral.com:8000"
  tenant = "mytenant"
  integration_name = "Okta"

  okta_app_name = "Cyral"
  okta_groups = ["Everyone"]
}
```
