terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.10"
    }
    cyral = {
      source = "cyralinc/cyral"
      version = ">= 1.2.0"
    }
  }
}