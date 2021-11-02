terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.17"
    }
    cyral = {
      source = "cyralinc/cyral"
      version = ">= 2.1.2"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
