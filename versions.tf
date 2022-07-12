terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      # The Okta Provider version is being restricted to <= 3.30.0 due to a breaking 
      # change introduced in 3.31.0. There's an issue registered in the Okta Provider 
      # repository reporting this (https://github.com/okta/terraform-provider-okta/issues/1202).
      # Once this issue gets fixed, we can update the version constraint back to "~> 3.17",
      # so that the module can use the latest version of the Okta Provider.
      version = "~> 3.17, <= 3.30.0"
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
