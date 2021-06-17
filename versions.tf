terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.10"
    }
    cyral = {
      source = "cyral.com/terraform/cyral"
      version = ">= 1.1.0"
    }
  }
}