---
title:  "psPAS Release 4.5"
date:   2020-11-25 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Set-PASAccount
  - Get-PASDiscoveredAccount
  - Add-PASDiscoveredAccount
  - Remove-PASAuthenticationMethod
  - Remove-PASOpenIDConnectProvider
  - Set-PASOpenIDConnectProvider
  - Get-PASOpenIDConnectProvider
  - Add-PASOpenIDConnectProvider
---

## **4.5.90** (November 25th 2020)

- Fixes
  - `Set-PASAccount`
    - Fix issue where JSON was not formatted as required when attempting to execute multiple operations in a single request.

## **4.5.87** (November 25th 2020)

### Module update to cover all CyberArk 11.7 API features

- New Functions
  - `Add-PASOpenIDConnectProvider`
    - Adds a new OIDC authentication provider configuration
  - `Get-PASOpenIDConnectProvider`
    - Lists configured OIDC authentication providers
  - `Set-PASOpenIDConnectProvider`
    - Updates a configured OIDC authentication provider
  - `Remove-PASOpenIDConnectProvider`
    - Deletes a configured OIDC authentication provider
  - `Remove-PASAuthenticationMethod`
    - Deletes a configured auth method
- Updated Functions
  - `Add-PASDiscoveredAccount`
    - Adds support for Azure platform
  - `Get-PASDiscoveredAccount`
    - Adds support for Azure platform
- Other Updates & Fixes
  - `Set-PASAccount`
    - Fix issue where JSON was truncated when attempting to perform multiple operations.
  - `New-PASSession`
    - Fix issue where `concurrentSession` body was not sent with request when using integrated authentication.
  - Replaced comment based help with external help.
