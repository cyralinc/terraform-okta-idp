# Change Log

## 3.0.3 - (July 12, 2022)

Minimum required Control Plane version: `v2.25.0`.

### Bug fix:

* Pin Okta Provider version to `<= 3.30.0` ([#15](https://github.com/cyralinc/terraform-okta-idp/pull/15))


## 3.0.2 - (June 21, 2022)

Minimum required Control Plane version: `v2.25.0`.

### Bug fix:

* Update SSO URLs to support SP and IdP Initiated SSO ([#14](https://github.com/cyralinc/terraform-okta-idp/pull/14))

## 3.0.1 - (June 9, 2022)

Minimum required Control Plane version: `v2.25.0`.

### Bug fix:

* Fixes redirect endpoint used in okta app ([#13](https://github.com/cyralinc/terraform-okta-idp/pull/13))

## 3.0.0 - (June 6, 2022)

Minimum required Control Plane version: `v2.25.0`.

### Feature:

* Rename repository to `terraform-okta-idp` ([#12](https://github.com/cyralinc/terraform-okta-idp/pull/12))

## 2.1.1 - (March 30, 2022)

Minimum required Control Plane version: `v2.25.0`.

### Bugfix:

* Fix extra bracket around userName for subject_name_id_template ([#11](https://github.com/cyralinc/terraform-okta-idp/pull/11))

## 2.1.0 - (December 29, 2021)

Minimum required Control Plane version: `v2.25.0`.

### Features:

* Add a parameter to control Okta filters for groups ([#10](https://github.com/cyralinc/terraform-okta-idp/pull/10))

## 2.0.0 - (November 4, 2021)

Minimum required Control Plane version: `v2.25.0`.

### Features:
* Update IDP Okta module with new sso integration resource ([#7](https://github.com/cyralinc/terraform-okta-idp/pull/7));

### Bug fixes:

* Remove email_domains and make optional tenant_name ([#3](https://github.com/cyralinc/terraform-okta-idp/pull/3));

## 1.0.0 (June 17, 2021)

### Features:
* Module initial release: ([#1](https://github.com/cyralinc/terraform-okta-idp/pull/1));