# Cyral IdP Integration Module for Okta

This module provides the complete configuration to integrate Okta as an Identity Provider to Cyral Control Plane. It applies an equivalent configuration as described in the [Cyral documentation for Okta SSO](https://cyral.com/docs/sso/sso-okta/).

-> Minimum required Control Plane version: `v2.25.0`

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
      version = "~> 4.3"
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

  control_plane = "mytenant.cyral.com"
}

provider "okta" {
  org_name  = "your-organization-name"
  base_url  = "okta.com" # your organization url
  api_token = ""
}

module "cyral_idp_okta" {
  source = "cyralinc/idp/okta"
  version = "~> 4.0"

  okta_app_name = "Cyral"
  okta_groups = ["Everyone"]
  
  idp_integration_name = "Okta"
}

output "integration_idp_okta_id" {
  description = "The ID (Alias) of the Okta IdP Integration resource."
  value = module.cyral_idp_okta.integration_idp_okta_id
}

output "okta_app_saml_id" {
  description = "The ID of the Okta SAML Application resource."
  value = module.cyral_idp_okta.okta_app_saml_id
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cyral"></a> [cyral](#requirement\_cyral) | ~> 4.3 |
| <a name="requirement_okta"></a> [okta](#requirement\_okta) | ~> 3.17 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cyral"></a> [cyral](#provider\_cyral) | ~> 4.3 |
| <a name="provider_okta"></a> [okta](#provider\_okta) | ~> 3.17 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cyral_integration_idp_saml.this](https://registry.terraform.io/providers/cyralinc/cyral/latest/docs/resources/integration_idp_saml) | resource |
| [cyral_integration_idp_saml_draft.this](https://registry.terraform.io/providers/cyralinc/cyral/latest/docs/resources/integration_idp_saml_draft) | resource |
| [okta_app_group_assignments.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_group_assignments) | resource |
| [okta_app_saml.this](https://registry.terraform.io/providers/okta/okta/latest/docs/resources/app_saml) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [cyral_saml_certificate.this](https://registry.terraform.io/providers/cyralinc/cyral/latest/docs/data-sources/saml_certificate) | data source |
| [cyral_saml_configuration.this](https://registry.terraform.io/providers/cyralinc/cyral/latest/docs/data-sources/saml_configuration) | data source |
| [okta_group.this](https://registry.terraform.io/providers/okta/okta/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_idp_integration_name"></a> [idp\_integration\_name](#input\_idp\_integration\_name) | IdP integration name that will be shown in Control Plane. | `string` | n/a | yes |
| <a name="input_okta_app_name"></a> [okta\_app\_name](#input\_okta\_app\_name) | The name of the Okta Application that will be created. | `string` | n/a | yes |
| <a name="input_okta_groups"></a> [okta\_groups](#input\_okta\_groups) | Groups that will be assigned in the Okta Application. | `list(string)` | `[]` | no |
| <a name="input_okta_groups_filter"></a> [okta\_groups\_filter](#input\_okta\_groups\_filter) | The type and value of the filter that will be applied to Okta groups. | <pre>object({<br>    type  = string<br>    value = string<br>  })</pre> | <pre>{<br>  "type": "REGEX",<br>  "value": ".*"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_integration_idp_okta_id"></a> [integration\_idp\_okta\_id](#output\_integration\_idp\_okta\_id) | The ID (Alias) of the Okta IdP Integration resource. |
| <a name="output_okta_app_saml_id"></a> [okta\_app\_saml\_id](#output\_okta\_app\_saml\_id) | The ID of the Okta SAML Application resource. |
<!-- END_TF_DOCS -->