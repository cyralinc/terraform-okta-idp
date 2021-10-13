terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.14"
    }
    cyral = {
      source = "cyralinc/cyral"
      version = ">= 2.0.1"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
