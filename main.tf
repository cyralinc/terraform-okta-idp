terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.10"
    }
    cyral = {
      source = "cyral.com/terraform/cyral"
    }
  }
}

locals {
  endpoint = format("%s/broker/%v/endpoint",local.issuer_endpoint, var.integration_name)
  issuer_endpoint = format("https://%v/auth/realms/%s", var.control_plane, var.tenant)
}

data "cyral_saml_certificate" "name" {
}

data "okta_app_metadata_saml" "name" {
  app_id = okta_app_saml.okta_app.id
}

output "samlmeta" {
  value = data.okta_app_metadata_saml.name
}

resource "cyral_integration_okta" "okta_integration" {
  signin_url = okta_app_saml.okta_app.http_post_binding
  signout_url = replace(okta_app_saml.okta_app.http_post_binding, "sso", "slo")

  name = var.integration_name

  certificate = okta_app_saml.okta_app.certificate

  # set this to your users' email domains
  email_domains = var.email_domains
}

resource "okta_app_saml" "okta_app" {
  label = "Cyral"

  groups = var.assigned_groups

  sp_issuer = local.issuer_endpoint
  single_logout_issuer = local.issuer_endpoint

  sso_url = local.endpoint
  recipient = local.endpoint
  destination = local.endpoint
  audience = local.endpoint

  single_logout_url = local.endpoint
  single_logout_certificate = data.cyral_saml_certificate.name.certificate

  subject_name_id_template = "$${{user.userName}}"
  subject_name_id_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

  response_signed = true
  signature_algorithm = "RSA_SHA256"
  digest_algorithm = "SHA256"
  authn_context_class_ref  = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

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
    filter_type = "REGEX"
    filter_value = ".*"
    namespace = "urn:oasis:names:tc:SAML:2.0:attrname-format:basic"
  }
}
