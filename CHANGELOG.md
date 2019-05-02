# psPAS

## 2.6.15 (May 2nd 2019)

### Module update to cover CyberArk 10.9 API features

- Updated Functions
  - `New-PASUser`
    - Added support for the updated Add User API method for v10.9
  - `Get-PASUser`
    - Added support for the updated Get Users API method for v10.9

## 2.5.11 (April 30th 2019)

- Updates
  - `Get-PASSafeMember`
    - Added `MemberName` parameter
      - Returns all safe permissions of a specific user.
  - `Get-PASAccountActivity`
    - Added Alias `id` to `AccountID` parameter
  - `Invoke-PASCredChange`
    - Added Alias `id` to `AccountID` parameter
  - `Invoke-PASCredReconcile`
    - Added Alias `id` to `AccountID` parameter
  - `Invoke-PASCredVerify`
    - Added Alias `id` to `AccountID` parameter
  - `Start-PASCredChange`
    - Added Alias `id` to `AccountID` parameter
  - `Start-PASCredVerify`
    - Added Alias `id` to `AccountID` parameter
  - `Unlock-PASAccount`
    - Added Alias `id` to `AccountID` parameter

## 2.5.6 (April 11th 2019)

- Fix
  - `Add-PASApplication`
    - Parameter `BusinessOwnerPhone` changed to `[string]` type

## 2.5.2 (April 6th 2019)

- Updated Functions (Thanks [steveredden](https://github.com/steveredden)!)
  - `Get-PASAccount`
    - Support for nextLink implemented to return maximum number of query results.
    - TimeoutSec parameter added
  - `Get-PASSafe`
    - TimeoutSec parameter added

## 2.5.0 (March 28th 2019)

### Module update to cover CyberArk 10.7 API features

- New Functions
  - `Get-PASDirectoryMapping`
    - Get directory mappings configured for a directory
  - `Get-PASDirectoryMapping`
    - Adds a new Directory Mapping for an existing directory
  - `Remove-PASDirectory`
    - Removes a directory configured in the Vault
- Updated Functions
  - `Add-PASDirectory`
    - Added parameter `DCList`
  - `Get-PASDirectory`
    - Function output updated to contain more properties
  - `New-PASDirectoryMapping`
    - Added parameters `VaultGroups`, `Location`, `LDAPQuery`
  - `Set-PASSafe`
    - Now supports renaming a safe via `NewSafeName` parameter
- Other Updates
  - Updated comment based help content based on user feedback.

## 2.4.8 (February 16th 2019)

- Updated Functions / Bug Fix / Breaking Change
  - `Close-PASSession`
    - Now sends request to V10 URL by default.
    - New parameter added to send request to V9 API if required.
  - `psPAS.psm1`
    - Updated to improve module load time.
    - Original import method can be forced by specifying `Import-Module -Name psPAS -ArgumentList $true`

- Fixed
  - `New-PASSession`
    - Fixed unexpected element in request body when specifying UseDefaultCredentials with Windows Authentication.

## 2.4.3 (February 15th 2019)

- Bug Fix
  - Remove debug output which could contain plaintex passwords.
    - Thanks [karrth](https://github.com/karrth)!

## 2.4.0 (February 1st 2019)

### Module update to cover CyberArk 10.6 API features

- New Functions
  - `Get-PASPSMSessionActivity`
    - Returns activity details from an active PSM Session.
  - `Get-PASPSMSessionProperty`
    - Returns property details from an active PSM Session.
  - `Get-PASPSMRecordingActivity`
    - Returns activity details from a PSM Recording.
  - `Get-PASPSMRecordingProperty`
    - Returns property details from a PSM Recording.
  - `Export-PASPSMRecording`
    - Allows saving of PSM Session Recording to a file.
  - `Request-PASAdHocAccess`
    - Enablex request of temporary administrative access to a server.
- Updated Functions
  - `Get-PASPSMRecording`
    - Now able to query PSM recordings by ID.
  - `Get-PASAccount`
    - Updated to include return of `InternalProperties` property when using the V9 API.
  - `Get-PASPSMConnectionParameter`
    - Added support for RDP File output

## 2.3.6 (December 2nd 2018)

- Fixed
  - `Invoke-PASRestMethod`
    - Specify "UseBasicParsing" on each request to prevent issues when run on machines which do not have IE available and initialized.

## 2.3.0 (November 1st 2018)

### Module update to cover CyberArk 10.5 API features

- New Functions
  - `Get-PASGroup`
    - Enables querying of Vault Groups
  - `Remove-PASGroupMember`
    - Enables removal of vault group members
  - `Set-PASOnboardingRule`
    - Enables updates to existing Onboarding Rules
  - `Add-PASDiscoveredAccount`
    - Enables addition of discovered accounts or SSH keys as a pending account in the accounts feed
  - `Connect-PASPSMSession`
    - Retrieves parameters needed to monitor an in-progress PSM session

- Updated Functions
  - `Get-PASDirectory`
    - Now possible to query LDAP Directory by name
  - `Get-PASAccountGroup`
    - Updated to use API endpoint in 10.5
  - `Get-PASPSMConnectionParameter`
    - Updated to cater for Ad-Hoc Connections with unmanaged accounts

- Bug Fixes
  - Use of TLS 1.2 Protocol enforced when using PSCore

## 2.2.22 (October 21st 2018)

- Update
  - `New-PASSession`
    - Option added to use Windows integrated authentication with default credentials
      - Thanks [steveredden](https://github.com/steveredden)!

## 2.2.10 (September 23rd 2018)

- Bug Fix
  - `Get-PASAccountPassword`
    - Fix applied to allow accountID from version 10 to be accepted from pipeline object.
  - `Get-PASAccount`
    - Validation added to `limit` parameter.

## 2.2.2 (September 12th 2018)

- Bug Fix
  - `Get-PASAccountPassword`
    - Backward compatibility for retrieving password values from  CyberArk version 9 restored.

## 2.2.0 (July 27th 2018)

- Bug Fix
  - `Export-PASPlatform`
    - Exported files were invalid, now fixed.
    - Thanks [jmk-foofus](https://github.com/jmk-foofus)!

## 2.1.0 (July 18th 2018)

- New Functions
  - `Get-PASPTAEvent` - function added, returns security events from PTA.
  - `Get-PASPTARule` - function added, returns rules from PTA.
  - `Get-PASPTARemediation` - function added, returns automatic remediation settings frm PTA.
  - `Add-PASPTARule` - function added, adds a new rule to PTA.
  - `Set-PASPTARule` - function added, updates a rule in PTA.
  - `Set-PASPTARemediation` - function added, updates automatic remediation.settings in PTA.

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