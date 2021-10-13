output "integration_saml_okta_id" {
  description = "The ID (Alias) of the Okta SAML Integration resource."
  value = cyral_integration_saml_okta.this.id
}

output "okta_app_saml_id" {
  description = "The ID of the Okta SAML Application resource."
  value = okta_app_saml.this.id
}