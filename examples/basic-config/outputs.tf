output "integration_sso_okta_id" {
  description = "The ID (Alias) of the Okta SSO Integration resource."
  value = module.cyral_sso_okta.integration_sso_okta_id
}

output "okta_app_saml_id" {
  description = "The ID of the Okta SAML Application resource."
  value = module.cyral_sso_okta.okta_app_saml_id
}
