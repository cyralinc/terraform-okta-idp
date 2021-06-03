# Okta Cyral integration module

This repository contains a module to provide a complete configuration of both a Cyral application on Okta and its integration on your Cyral Control Plane. It applies an equivalent configuration as described in the [Cyral documentation for Okta SSO](https://cyral.com/docs/sso-okta).


## Quick Start

To deploy a fully configured application with its pair cyral integration:

1. Modify main.tf to add both your Okta credentials and your Control Plane credentials.
	- To get Cyral's credentials, refer to the [compatibility session on Cyral's terraform provider](https://github.com/cyralinc/terraform-provider-cyral#compatibility).
2. You can then run terraform apply to start creating your integration.
