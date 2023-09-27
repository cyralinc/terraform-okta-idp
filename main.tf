resource "random_uuid" "this" {
}

locals {
  idp_initiated_sso_endpoint = element(flatten([
    for obj in cyral_integration_idp_saml_draft.this.service_provider_metadata : obj.assertion_consumer_services[*].url
  ]), 0)
  sp_entity_id_endpoint     = element(cyral_integration_idp_saml_draft.this.service_provider_metadata.*.entity_id, 0)
  sp_initiated_sso_endpoint = element(cyral_integration_idp_saml_draft.this.service_provider_metadata.*.single_logout_url, 0)
  config                    = data.cyral_saml_configuration.this
}

data "cyral_saml_certificate" "this" {
}

resource "okta_app_saml" "this" {
  label = var.okta_app_name

  sso_url       = local.idp_initiated_sso_endpoint
  recipient     = local.idp_initiated_sso_endpoint
  destination   = local.idp_initiated_sso_endpoint
  audience      = local.sp_entity_id_endpoint
  acs_endpoints = [local.idp_initiated_sso_endpoint, local.sp_initiated_sso_endpoint]

  subject_name_id_template = "$${user.userName}"
  subject_name_id_format   = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed          = true
  signature_algorithm      = "RSA_SHA256"
  digest_algorithm         = "SHA256"
  honor_force_authn        = true
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  assertion_signed = true
  sp_issuer        = local.sp_entity_id_endpoint

  single_logout_issuer      = local.sp_entity_id_endpoint
  single_logout_url         = local.sp_initiated_sso_endpoint
  single_logout_certificate = data.cyral_saml_certificate.this.certificate

  attribute_statements {
    name      = "email"
    type      = "EXPRESSION"
    values    = ["user.email"]
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  attribute_statements {
    name      = "firstName"
    type      = "EXPRESSION"
    values    = ["user.firstName"]
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  attribute_statements {
    name      = "lastName"
    type      = "EXPRESSION"
    values    = ["user.lastName"]
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  attribute_statements {
    name         = "memberOf"
    type         = "GROUP"
    filter_type  = var.okta_groups_filter.type
    filter_value = var.okta_groups_filter.value
    values       = []
    namespace    = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  lifecycle {
    ignore_changes = [
      # This is needed because Okta stores the certificate with line breaks, which would cause
      # a plan at every apply
      single_logout_certificate,
    ]
  }
}

data "okta_group" "this" {
  for_each = toset(var.okta_groups)
  name     = each.key
}

resource "okta_app_group_assignments" "this" {
  count  = length(var.okta_groups) > 0 ? 1 : 0
  app_id = okta_app_saml.this.id
  dynamic "group" {
    for_each = toset([for g in data.okta_group.this : g.id])
    content {
      id = group.key
    }
  }
}

data "cyral_saml_configuration" "this" {
  base_64_saml_metadata_document = base64encode(okta_app_saml.this.metadata)
}

resource "cyral_integration_idp_saml_draft" "this" {
  display_name                = var.idp_integration_name
  idp_type                    = "okta"
  disable_idp_initiated_login = false
}

resource "cyral_integration_idp_saml" "this" {
  saml_draft_id = cyral_integration_idp_saml_draft.this.id
  # This is the IdP metadata document. You may choose instead to
  # provide the url for the metadata XML document using
  # the argument `idp_metadata_url`.
  idp_metadata_xml = local.config.base_64_saml_metadata_document
}
