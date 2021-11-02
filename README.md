# Cyral Okta SSO Integration Module

This module provides a complete configuration to create an Okta SSO Integration on a Cyral Control Plane. It applies an equivalent configuration as described in the [Cyral documentation for Okta SSO](https://cyral.com/docs/sso/sso-okta).

## Note

This module will only work for Control Planes with version >= 2.25.

## Usage

```terraform
terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.17"
    }
    cyral = {
      source = "cyralinc/cyral"
      version = ">= 2.1.2"
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
  base_url  = "okta.com" # your organization url
  api_token = ""
}

module "cyral_sso_okta" {
  source = "cyralinc/sso-okta/cyral"
  version = ">= 2.0.0"

  control_plane = "mytenant.cyral.com:8000"
  tenant = "default"
  
  okta_app_name = "Cyral"
  okta_groups = ["Everyone"]

  sso_integration_name = "Okta SSO"
  back_channel_logout = false
  wants_assertion_encrypted = false
  disable_force_authentication = true
  allowed_clock_skew = 0
}

output "integration_sso_okta_id" {
  description = "The ID (Alias) of the Okta SSO Integration resource."
  value = module.cyral_sso_okta.integration_sso_okta_id
}

output "okta_app_saml_id" {
  description = "The ID of the Okta SAML Application resource."
  value = module.cyral_sso_okta.okta_app_saml_id
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cyral"></a> [cyral](#requirement\_cyral) | >= 2.1.2 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | ~> 3.17 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cyral"></a> [cyral](#provider\_cyral) | >= 2.1.2 |
| <a name="provider_okta"></a> [okta](#provider\_okta) | ~> 3.17 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cyral_integration_sso_okta.this](https://registry.terraform.io/providers/cyralinc/cyral/latest/docs/resources/integration_sso_okta) | resource |
| [okta_app_group_assignments.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignments) | resource |
| [okta_app_saml.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [cyral_saml_certificate.this](https://registry.terraform.io/providers/cyralinc/cyral/latest/docs/data-sources/saml_certificate) | data source |
| [cyral_saml_configuration.this](https://registry.terraform.io/providers/cyralinc/cyral/latest/docs/data-sources/saml_configuration) | data source |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_clock_skew"></a> [allowed\_clock\_skew](#input\_allowed\_clock\_skew) | Clock skew in seconds that is tolerated when validating Identity Provider tokens. | `number` | `null` | no |
| <a name="input_back_channel_logout"></a> [back\_channel\_logout](#input\_back\_channel\_logout) | Indicates whether or not the Okta Identity Provider supports backchannel logout. | `bool` | `null` | no |
| <a name="input_control_plane"></a> [control\_plane](#input\_control\_plane) | Control plane host and API port (ex: some-cp.cyral.com:8000). | `string` | n/a | yes |
| <a name="input_disable_force_authentication"></a> [disable\_force\_authentication](#input\_disable\_force\_authentication) | Indicates whether the Okta Identity Provider must authenticate the presenter directly rather than rely on a previous security context. | `bool` | `null` | no |
| <a name="input_okta_app_name"></a> [okta\_app\_name](#input\_okta\_app\_name) | The name of the app that will be created in Okta. | `string` | n/a | yes |
| <a name="input_okta_groups"></a> [okta\_groups](#input\_okta\_groups) | Groups that the cyral app will be assigned to in Okta. | `list(string)` | `[]` | no |
| <a name="input_sso_integration_name"></a> [sso\_integration\_name](#input\_sso\_integration\_name) | SSO integration name that will be shown in Control Plane. | `string` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant associated with the Control Plane. | `string` | `"default"` | no |
| <a name="input_wants_assertion_encrypted"></a> [wants\_assertion\_encrypted](#input\_wants\_assertion\_encrypted) | Indicates whether the Cyral Service Provider expects an encrypted assertion. | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_integration_sso_okta_id"></a> [integration\_sso\_okta\_id](#output\_integration\_sso\_okta\_id) | The ID (Alias) of the Okta SSO Integration resource. |
| <a name="output_okta_app_saml_id"></a> [okta\_app\_saml\_id](#output\_okta\_app\_saml\_id) | The ID of the Okta SAML Application resource. |
