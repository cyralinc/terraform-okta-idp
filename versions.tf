terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "3.30.0"
    }
    cyral = {
      source = "cyralinc/cyral"
      version = ">= 2.2.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
