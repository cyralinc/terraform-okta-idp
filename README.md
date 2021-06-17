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
  integration_name = "Okta SSO"
  email_domains = ["mydomain.com"]

  okta_app_name = "Cyral"
  okta_groups = ["Everyone"]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cyral"></a> [cyral](#requirement\_cyral) | >= 1.1.0 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | ~> 3.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cyral"></a> [cyral](#provider\_cyral) | >= 1.1.0 |
| <a name="provider_okta"></a> [okta](#provider\_okta) | ~> 3.10 |

## Resources

| Name | Type |
|------|------|

| cyral_integration_okta.okta_integration | resource |
| [okta_app_saml.okta_app](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml) | resource |

| cyral_saml_certificate.name | data source |
| [okta_app_metadata_saml.name](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/app_metadata_saml) | data source |
| [okta_group.groups](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_plane"></a> [control\_plane](#input\_control\_plane) | Control plane host and API port (ex: some-cp.cyral.com:8000) | `string` | n/a | yes |
| <a name="input_email_domains"></a> [email\_domains](#input\_email\_domains) | Email domains that will be accepted as valid logins. | `list(string)` | `[]` | no |
| <a name="input_integration_name"></a> [integration\_name](#input\_integration\_name) | Integration name that will be shown in Control Plane. | `string` | n/a | yes |
| <a name="input_okta_app_name"></a> [okta\_app\_name](#input\_okta\_app\_name) | The name of the app that will be created in Okta. | `string` | n/a | yes |
| <a name="input_okta_groups"></a> [okta\_groups](#input\_okta\_groups) | Groups that the cyral app will be assigned to in Okta. | `list(string)` | `[]` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant associated with the control plane | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_samlmeta"></a> [samlmeta](#output\_samlmeta) | n/a |
