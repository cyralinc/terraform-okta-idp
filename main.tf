resource "random_uuid" "this" {
}

locals {
  sp_entity_id_endpoint = format(
    "https://%s/auth/realms/%s",
    var.control_plane, var.tenant
  )
  idp_integration_alias = format("okta.%s", random_uuid.this.result)
  sp_initiated_sso_endpoint = format(
    "%s/broker/%s/endpoint",
    local.sp_entity_id_endpoint, local.idp_integration_alias
  )
  idp_initiated_sso_endpoint = format(
    "%s/clients/%s-client",
    local.sp_initiated_sso_endpoint, local.idp_integration_alias
  )
  config = data.cyral_saml_configuration.this
}

data "cyral_saml_certificate" "this" {
}

resource "okta_app_saml" "this" {
  label = var.okta_app_name

  sso_url = local.idp_initiated_sso_endpoint
  recipient = local.idp_initiated_sso_endpoint
  destination = local.idp_initiated_sso_endpoint
  audience = local.sp_entity_id_endpoint
  acs_endpoints = [local.idp_initiated_sso_endpoint, local.sp_initiated_sso_endpoint]

  subject_name_id_template = "$${user.userName}"
  subject_name_id_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  response_signed = true
  signature_algorithm = "RSA_SHA256"
  digest_algorithm = "SHA256"
  honor_force_authn = true
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  assertion_signed = true
  sp_issuer = local.sp_entity_id_endpoint

  single_logout_issuer = local.sp_entity_id_endpoint
  single_logout_url = local.sp_initiated_sso_endpoint
  single_logout_certificate = data.cyral_saml_certificate.this.certificate

  attribute_statements {
    name = "EMAIL"
    type = "EXPRESSION"
    values = ["user.email"]
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  attribute_statements {
    name = "FIRST_NAME"
    type = "EXPRESSION"
    values = ["user.firstName"]
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  attribute_statements {
    name = "LAST_NAME"
    type = "EXPRESSION"
    values = ["user.lastName"]
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  attribute_statements {
    name = "groups"
    type = "GROUP"
    filter_type = var.okta_groups_filter.type
    filter_value = var.okta_groups_filter.value
    values = []
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }

  lifecycle {
    ignore_changes = [
      # This is needed because Okta stores the certificate with line breaks, which would cause
      # a plan at every apply
      single_logout_certificate,
      # This is needed because Okta still updating `groups` field even though its 
      # deprecated.
      groups,
    ]
  }
}

data "okta_group" "this" {
  for_each = toset(var.okta_groups)
  name = each.key
}

resource "okta_app_group_assignments" "this" {
  count = length(var.okta_groups) > 0 ? 1 : 0
  app_id   = okta_app_saml.this.id
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

resource "cyral_integration_idp_okta" "this" {
  draft_alias = local.idp_integration_alias
  samlp {
    display_name = var.idp_integration_name
    config {
      single_sign_on_service_url = local.config.single_sign_on_service_url
      single_logout_service_url = local.config.single_logout_service_url == "" ? null : local.config.single_logout_service_url
      disable_using_jwks_url = local.config.disable_using_jwks_url
      sync_mode = local.config.sync_mode == "" ? null : local.config.sync_mode
      name_id_policy_format = local.config.name_id_policy_format == "" ? null : local.config.name_id_policy_format
      principal_type = local.config.principal_type == "" ? null : local.config.principal_type
      signature_type = local.config.signature_type == "" ? null : local.config.signature_type
      saml_xml_key_name_tranformer = local.config.saml_xml_key_name_tranformer == "" ? null : local.config.saml_xml_key_name_tranformer
      hide_on_login_page = local.config.hide_on_login_page
      back_channel_supported = var.back_channel_logout == null ? local.config.back_channel_supported : var.back_channel_logout
      disable_post_binding_response = local.config.disable_post_binding_response
      disable_post_binding_authn_request = local.config.disable_post_binding_authn_request
      disable_post_binding_logout = local.config.disable_post_binding_logout
      want_assertions_encrypted = var.wants_assertions_encrypted == null ? local.config.want_assertions_encrypted : var.wants_assertions_encrypted
      disable_force_authentication = var.disable_force_authentication == null ? local.config.disable_force_authentication : var.disable_force_authentication
      gui_order = local.config.gui_order == "" ? null : local.config.gui_order
      xml_sig_key_info_key_name_transformer = local.config.xml_sig_key_info_key_name_transformer == "" ? null : local.config.xml_sig_key_info_key_name_transformer
      signing_certificate = local.config.signing_certificate == "" ? null : local.config.signing_certificate
      allowed_clock_skew = var.allowed_clock_skew == null ? local.config.allowed_clock_skew : var.allowed_clock_skew
      saml_metadata_url = local.config.saml_metadata_url == "" ? null : local.config.saml_metadata_url
      base_64_saml_metadata_document = local.config.base_64_saml_metadata_document == "" ? null : local.config.base_64_saml_metadata_document
      ldap_group_attribute = local.config.ldap_group_attribute == "" ? null : local.config.ldap_group_attribute
    }
  }
}
