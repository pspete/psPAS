# psPAS Changelog

## 2.0.4 (July 8th 2018)

- Updated Function
  - `Set-PASAccount`, updated to support new 10.4 API features.
    - Thanks [Assaf](https://github.com/AssafMiron)!

## 2.0.0 (July 1st 2018)

_The 1 year since first commit anniversary edition_

### Module update to cover CyberArk 10.4 API features

- Breaking Changes
  - `New-PASSession`
    - Function now defaults to the v10 API Endpoints
    - Users on CyberArk Version 9 need to specify the `-UseV9API` switch parameter
  - `New-PASOnboardingRule`
    - Function now defaults to the ParameterSet relating to version 10.2 onwards
  - `Add-PASPendingAccount`
    - Parameter `AccountDiscoveryDate` changed to type `[datetime]`
  - `Add-PASApplication`
    - Parameter `ExpirationDate` changed to type `[datetime]`
  - `Add-PASSafeMember`
    - Parameter `MembershipExpirationDate` changed to type `[datetime]`
  - `Set-PASSafeMember`
    - Parameter `MembershipExpirationDate` changed to type `[datetime]`
  - `New-PASUser`
    - Parameter `ExpiryDate` changed to type `[datetime]`
  - `Set-PASUser`
    - Parameter `ExpiryDate` changed to type `[datetime]`

- New Functions
  - `Export-PASPlatform` function added, allows export of platform to a zip file.
  - `Get-PASUserLoginInfo` function added, retrieves logon information for the authenticated user.
  - `Add-PASDirectory` function added, adds a new LDAP directory for authentication.
  - `Get-PASDirectory` function added, lists LDAP directories.
  - `New-PASDirectoryMapping` function added, creates new LDAP Directory mappings.

- Bug Fixes
  - `New-PASSession`
    - Fixed issue where module was not returning authentication token when using LDAP credentials in version 10.3.
      - To use LDAP authentication the `-type LDAP` must be specified as a parameter.

- Other Updates
  - `Remove-PASAccount`, updated to support new 10.4 API features.
  - `Get-PASAccount`, updated to support new 10.4 API features.
  - Version Check:
    - All logon functions now attempt to query the version of CyberArk in use, and return the External Version number as an additional output property.
      - The version check after logon can be skipped by specifying the `-SkipVersionCheck` parameter.
    - Functions, or, functions with specific parameters, that have minimum version requirements will assert that the version being used can support the action being requested.
      - If a minimum version requirement is not met, a descriptive error will be thrown.
      - If the version of CyberArk is unknown, or the version check has been skipped, version assertion will not occur.
  - Output:
    - Any function that does return output, now includes the CyberArk ExternalVersion as a standard property.
      - This enables functions along the pipeline to receive the information and assert and minimum version requirements.
  - PSCore:
    - All testing via Appveyor has now been transitioned to, and is performed in, PSCore.

## 1.3.0 (June 5 2018)

### Module update to cover CyberArk 10.3 API features ~~(part 1)~~

- New Function
  - `Import-PASConnectionComponent` function added, allows import of connection component from zip file.

- Bug Fixes
  - Updates to some functions and test scripts to fix Pester & PSScriptAnalyzer failures/violations/errors
  - Updates to some pester tests to allow them to run & pass in PowerShell Core

- Other Updates
  - Build, Test, Deploy process updated to run in PowerShell Core instead of Windows PowerShell 5
  - Removed about_psPAS_Versions.help.txt - an unhelpful help file.

## 1.2.5 (April 28 2018)

- Bug Fix:
  - Fix added to specify `-SkipHeaderValidation` on `Invoke-WebRequest` if using PowerShell Core.
    - Thanks [Serge](https://github.com/SNikalaichyk)!

## 1.2.3 (April 17 2018)

- Bug Fixes:
  - `New-PASSession`, `New-PASSAMLSession` & `New-PASSharedSession`
  prevented from providing output (except error message) in the
  event of a failure

## 1.2.0 (March 16 2018)

### Module updated to cover CyberArk 10.2 API features

- New Functions
  - `New-PASOnboardingRule` has added parameters available from 10.2 onwards.
    The 9.8 & 10.2 parameters are configured as separate parametersets.
  - `Get-PASOnboardingRule` has a new parameter added, allowing search of
     Onboarding rules by name in version 10.2
  - `Import-PASPlatform` function added, allowing import of CPM Platforms
  - `Get-PASPSMConnectionParameters` updated to facilitate return of HTML5
      connection data when PSMGW is configured.
  - `Suspend-PASPSMSession` & `Resume-PASPSMSession` functions added, expanding
     on the automatic mitigation capability for PSM Sessions.

- Attained 100% Code Coverage in the Tests for the module.

## 1.1.8 (March 09 2018)

- Bug Fixes:
  - ```Add-PASAccountGroupMember``` now sends AccountID with request.
  - ```New-PASAccountGroup``` fixed an incorrect parameter name (_GroupPlatformID_).
  - ```New-PASSAMLSession``` - basic authentication token now sent in request header.
  - ```Get-PASOnboardingRule```, ```New-PASOnboardingRule``` & ```Remove-PASOnboardingRule```,
    parameters updated to allow specification of alternate PVWA application name
    (in-line with the rest of the module's functions).

## 1.0.6 (February 12 2018)

Published to [PowerShell Gallery](http://powershellgallery.com/packages/psPAS)