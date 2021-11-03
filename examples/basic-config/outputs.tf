output "integration_idp_okta_id" {
  description = "The ID (Alias) of the Okta IdP Integration resource."
  value = module.cyral_idp_okta.integration_idp_okta_id
}

output "okta_app_saml_id" {
  description = "The ID of the Okta SAML Application resource."
  value = module.cyral_idp_okta.okta_app_saml_id
}
