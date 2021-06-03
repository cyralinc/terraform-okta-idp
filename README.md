# Cyral IDP Integration Module for Okta

This repository contains a module to provide a complete configuration of both a Cyral application on Okta and its integration on your Cyral Control Plane. It applies an equivalent configuration as described in the [Cyral documentation for Okta SSO](https://cyral.com/docs/sso-okta).

## Usage

```terraform
terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.10"
    }
    cyral = {
      source = "cyral.com/terraform/cyral"
      version = "~> 1.1"
    }
  }
}

provider "cyral" {
  control_plane = "mytenant.cyral.com:8000"
}

provider "okta" {
  org_name  = "your-organization"
  base_url  = "okta.com" # has to be set to your organization url
  api_token = "your-api-token"
}

module "okta" {
  source = "cyral/idp-okta"
  tenant = "mytenant"
  integration_name = "Okta"
  okta_app_name = "Cyral"
  control_plane = "mytenant.cyral.com:8000"
}
```

## Group assignement configuration

The groups that will be assigned to Cyral's app on Okta should be configured via their IDs. Those can be gotten from the [`okta_group` data source](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) on Okta's terraform providers.

```terraform
data "okta_group" "everyone" {
  name = "Everyone"
}

module "okta" {
  ...
  assigned_groups = [data.okta_group.everyone.id]
}
```
