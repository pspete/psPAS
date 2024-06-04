# psPAS

## Planned Updates / Unreleased

- Continued development to encompass any new documented features of the CyberArk API.
- psPAS v7.0...

## [unreleased]

### Added
- `Get-PASDiscoveryRuleSet`
  - Privilege Cloud only command to show configured discovery rule sets
- `New-PASDiscoveryRuleSet`
  - Privilege Cloud only command to create a discovery rule set
- `Set-PASDiscoveryRuleSet`
  - Privilege Cloud only command to update a discovery rule set
- `Remove-PASDiscoveryRuleSet`
  - Privilege Cloud only command to delete a discovery rule set

### Updated
- N/A

### Fixed
- N/A

## [6.4.85]

### Added
- N/A

### Updated
- N/A

### Fixed
- `Set-PASUser`
  - Adds logic to not attempt conversion to unix time if expiry date is not a valid datetime object, this resolves an issue where an error was raised when updating an account with an existing value for the `expirydate` property
  - Adds logic to not apply time zone offset when specifying Unix epoch time to remove an expiry date from an account which could previously result in an invalid time value in non-GMT time zones.

## [6.4.80]

Includes a general update across multiple module commands to ensure commands which are specific to self-hosted implementations are not able to be run against Privilege Cloud, and any commands which are specific to Privilege Cloud are not able to be run against a Self-Hosted solution.

### Added
- `Get-PASIPAllowList`
  - Privilege Cloud only command to show IP Allow List
- `Set-PASIPAllowList`
  - Privilege Cloud only command to set IP Allow List
- `Get-PASBYOKConfig`
  - Privilege Cloud only command to show BYOK Config
- `Publish-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to publish discovered local account
- `Get-PASDiscoveredLocalAccountActivity`
  - Privilege Cloud only command to show discovered local account activity
- `Get-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to show local discovered account details
- `Clear-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to delete all discovered local accounts from the Pending Accounts list.
- `Add-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to add a specific local account to the Discovered Accounts list
- `Remove-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to remove a local account from the Discovered Accounts list

### Updated
- `Invoke-PASRestMethod`
  - Improvements to error handling

### Fixed
- `Get-PASPSMRecording`
  - Fixes result paging issue
- `Get-PASPSMSession`
  - Fixes result paging issue

## **6.3.78**

### Added
- N/A

### Updated
- `Get-PASPSMRecording`
  - In-line with PVWA default operation:
    - Changed the default limit for each page of results to 100, in-line with PVWA default values
    - Updated to return recordings from the last 48 hours by default when `FromTime` & `ToTime` parameters are not specified.
  - When specifying `ToTime` without `FromTime`, recordings from the 48 hours before `ToTime` are returned.
    - This avoids potential for unintentionally long running queries which return details of many recording from the vault.
- `Set-PASUser`
  - Updated to query for, and send, any existing user properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the user object.
    - This update allows single properties to be updated without having to specify all properties.
  - Allows Empty argument for `unAuthorizedInterfaces` & `vaultAuthorization` parameters to enable set values to be cleared.
  - Corrects ValidateSet for `unAuthorizedInterfaces` parameter.
- `Set-PASSafe`
  - Updated to query for, and send, any existing properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the object.
    - This update allows single properties to be updated without having to specify all properties.
- `Set-PASOpenIDConnectProvider`
  - Updated to query for, and send, any existing properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the object.
    - This update allows single properties to be updated without having to specify all properties.
    - Number of mandatory parameters required to be specified has been reduced
- `Set-PASPTARule`
  - Updated to query for, and send, any existing properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the object.
    - This update allows single properties to be updated without having to specify all properties.
    - Number of mandatory parameters required to be specified has been reduced
- `Set-PASDirectoryMapping`
  - Updated to query for, and send, any existing properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the object.
    - This update allows single properties to be updated without having to specify all properties.
    - Number of mandatory parameters required to be specified has been reduced
- `New-PASOnboardingRule`
  - Reordered parameters to simplify tab completion options
- `Set-PASOnboardingRule`
  - Updated to query for, and send, any existing properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the object.
    - This update allows single properties to be updated without having to specify all properties.
    - Number of mandatory parameters required to be specified has been reduced
- `Set-PASPlatformPSMConfig`
  - Updated to query for, and send, any existing properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the object.
    - This update allows single properties to be updated without having to specify all properties.
    - Number of mandatory parameters required to be specified has been reduced
- `Set-PASSafeMember`
  - Updated to query for, and send, any existing properties, which are not being specifically updated, with the request.
    - Previously, due to the PUT operation used by the API, any properties not specified in a request would be cleared on the object.
    - This update allows single properties to be updated without having to specify all properties.
- `New-PASUser`
  - In-line with update to `Set-PASUser`
    - Allows Empty argument for `unAuthorizedInterfaces` & `vaultAuthorization` parameters.
    - Corrects ValidateSet for `unAuthorizedInterfaces` parameter.
- `Get-PASComponentDetail`
  - Adds assertion that command specifying `PTA` component  must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Add-PASAccountACL`
  - Adds assertion that command must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Get-PASAccountACL`
  - Adds assertion that command must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Remove-PASAccountACL`
  - Adds assertion that command must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Invoke-PASCPMOperation`
  - Adds assertion that Gen1 verify task must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Set-PASAccount`
  - Adds assertion that Gen1 task must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Close-PASSession`
  - Adds assertion that Shared Authentication logoff request is executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `New-PASSession`
  - Adds assertion that Shared Authentication logon request is executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Add-PASPolicyACL`
  - Adds assertion that command must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Get-PASPolicyACL`
  - Adds assertion that command must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Remove-PASPolicyACL`
  - Adds assertion that command must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Remove-PASSafeMember`
  - Adds assertion that command using Gen1 parameters must be executed against a self hosted implementation as invocation against privilege cloud is not supported.
- `Assert-VersionRequirement`
  - Updates helper function to provide ability to assert if command is being run against self-hosted or privilege cloud implementation.

### Fixed
- N/A

## **6.2.68**

### Added
- N/A

### Updated
- `Get-PASSession`
  - makes additional information available to users running the command
    - authentication time
    - session length
    - last command and result data
    - last error details
- `New-PASPSMSession`
  - RDP and PSMGW connections will be automatically opened when issuing  connection request.
- `New-PASSession`
  - Adds logic around getting the logged on user name for either self-hosted or privilege cloud deployments
- PSM Session Data Formats
  - Adds `Start` & `End` to standard table view output
  - Formats `Start` & `End` as standard datetime instead of unixtime.

### Fixed
- `Add-PASGroupMember`,`Remove-PASGroup`,`Set-PASGroup`
  - Standardises name of `ID` parameter.
  - Adds `GroupID` alias to `ID` parameter.

## **6.1.62**

### Added
- N/A

### Updated
- `Get-PASPSMRecording`
  - Removes `Offset` Parameter
  - Updates `FromTime` & `ToTime` parameters to `[datetime]` types
  - Returns all pages of results instead of only the first page of results
- `Get-PASPSMSession`
  - Removes `Offset` Parameter
  - Updates `FromTime` & `ToTime` parameters to `[datetime]` types
  - Returns all pages of results instead of only the first page of results
- `Get-PASAccount`
  - Removes `Offset` Parameter
- `Get-PASDiscoveredAccount`
  - Removes `Offset` Parameter

### Fixed
- `Get-PASSession`
  - Removes `UserName` from command output, avoiding error condition on expired session.
- `Get-PASPlatform`
  - Adds `search` parameter to the default `targets` parameterset
- ISPSS Error Handling
  - Fixes issue where error returned from ISPSS solution may not be handled properly

## **6.1.50**

### Module update to cover all CyberArk 14.0 API features

### Added
- `Add-PASPTAExcludedTarget`
  - New command, supported from 14.0
- `Add-PASPTAIncludedTarget`
  - New command, supported from 14.0
- `Add-PASPTAPrivilegedGroup`
  - New command, supported from 14.0
- `Add-PASPTAPrivilegedUser`
  - New command, supported from 14.0
- `Get-PASPTAExcludedTarget`
  - New command, supported from 14.0
- `Get-PASPTAIncludedTarget`
  - New command, supported from 14.0
- `Get-PASPTAPrivilegedGroup`
  - New command, supported from 14.0
- `Get-PASPTAPrivilegedUser`
  - New command, supported from 14.0
- `Remove-PASPTAExcludedTarget`
  - New command, supported from 14.0
- `Remove-PASPTAIncludedTarget`
  - New command, supported from 14.0
- `Remove-PASPTAPrivilegedGroup`
  - New command, supported from 14.0
- `Remove-PASPTAPrivilegedUser`
  - New command, supported from 14.0
- `Get-PASLinkedGroup`
  - New experimental command based on undocumented API.

 ### Updated
- `Get-PASAccountActivity`
  - Adds Gen2 replacement for deprecated Gen1 API.
  - Updates default operation to target Gen2 API.
- `Get-PASPTARiskEvent`
  - New filter parameters `FromTime` & `ToTime`
  - Fixes output and result paging
- `Set-PASPTARiskEvent`
  - New parameters `closeReason` & `reasonText`
  - General Fixes
- `New-PASDirectoryMapping`
  - New parameters `UsedQuota`, `AuthorizedInterfaces` & `EnableENEWhenDisconnected`
- `Set-PASDirectoryMapping`
  - New parameters `UsedQuota`, `AuthorizedInterfaces` & `EnableENEWhenDisconnected`

 ### Fixed
- `Invoke-PASRestMethod`
  - Avoids potential error condition when handling errors in ISPSS environments

## **6.0.30**

### Added
 - N/A

 ### Updated
- `Add-PASPTARule` & `Set-PASPTARule`
  - Adds scope parameters `vaultUsersMode`, `vaultUsersList`, `machinesMode` & `machinesList`
  - Includes scope property in output by default

 ### Fixed
- `Add-PASApplication`
   - Updates date format of `ExpirationDate` to `MM/dd/yyyy`. Resolves issue observed when sending date format of `MM-dd-yyyy`
- `Set-PASPTAEvent` & `Set-PASPTARiskEvent`
  - Fixes issue where websession object and auth header were not being sent with the request

## **6.0.21**

### Added
 - N/A

 ### Updated
 - N/A

 ### Fixed
 - Debug Trace Output
   - Resolves condition where authentication password value might be revealed in debug trace output in a scenario where  `Set-PSDebug -Trace 2` is active in the console host.

## **6.0.18**

### Added
- N/A

### Changed
- `Set-PASSafe`
  - Allows `0` as valid value for parameter `NumberOfDaysRetention`
- `Get-PASServerWebService`
  - Depreciates Gen1 endpoint from 13.2. Adds Gen2 endpoint as default.
- `Get-PASSafeShareLogo`
  - Depreciates command from 13.2.
- `Invoke-PASCPMOperation`
  - Depreciates Gen1 endpoint from 13.2.
- `Get-PASAccountActivity`
  - Depreciates command from 13.2.
- `Add-PASPendingAccount`
  - Depreciates command from 13.2.

### Fixed
- `Get-PASAccount`
  - Resolves issue where, if number of results of a `SavedFilter` are greater than the page size (either default or set via the `limit` parameter), only the URL of the first request sent would include the SavedFilter value.

## **6.0.4**

- Updated
  - `Add-PASSafeMember`
    - Adds 'Role' to acceptable values in ParameterSet for `memberType` parameter

## **6.0.0**

- Update & Breaking Change
  - `New-PASSession`
    - **All Privilege Cloud Shared Services Authentication via the CyberArk Identity Platform now depends on the pspete `IdentityCommand` module.**
    - Adds Identity User Authentication, using the `IdentityCommand` module to satisfy Identity MFA challenges and obtain required authentication token to use against Privileged Cloud Shared Services.
    - Adds logic to determine correct Identity tenant URL based on provided Privileged Cloud Subdomain value.
    - Both Privileged Cloud API URL & Identity Portal URL are required to be specified if subdomain value is not provided.
    - Service User authentication for Shared Services introduced in recent previous versions requires installation of `IdentityCommand` module and specification of additional attribute.
    - See [the docs](https://pspas.pspete.dev/docs/authentication/#shared-services-authentication) & [New-PASSession](https://pspas.pspete.dev/commands/New-PASSession) for full details.

## **5.6.135 (July 31st 2023)**

### Module update to cover all CyberArk 13.2 API features

**psPAS Year 6**

- New
  - `Get-PASUserTypeInfo`
    - Output information on User Types
  - `Get-PASPTARiskEvent`
    - Output PTA Risk Events
  - `Set-PASPTARiskEvent`
    - Update PTA Risk Events
  - `Get-PASPTARiskSummary`
    - Output PTA Risk Summary
  - `New-PASRequestObject`
    - Enables creation of request objects for bulk account access requests using `New-PASRequest`.
- Updates
  - `New-PASSession`
    - Adds option for PKIPN authentication.
      - Thanks ([JesseMcWilliamss](https://github.com/JesseMcWilliamss))!
    - Adds options to Shared Services Authentication capability
      - Supports different subdomains for Identity & Privilege Cloud tenants
      - Supports ability to provide tenant URLs for Identity & Privilege Cloud systems.
  - `Unlock-PASAccount`
    - Adds Unlock capability, in addition to the existing check-in capability.
      - Thanks & Credit to ([Qrelis](https://github.com/Qrelis))for this!
  - `Get-PASUser`
    - Adds `source` parameter (allows filter by cyberark or ldap source).
    - Adds `userStatus` parameter (allows filter by active, disabled, or suspended status).
  - `New-PASUser` & `Set-PASUser`
    - Adds parameters `userActivityLogRetentionDays`, `loginFromHour` & `loginToHour`
  - `New-PASRequest`
    - Adds new ParameterSets `BulkSearch`, `BulkFilter` & `BulkItems`.
  - `Get-PASRequest`
    - Adds `id` parameter to support get status bulk request actions.

## **5.5.110 (March 7th 2023)**

### Module update to cover all CyberArk 13.0 API features

- New
  - Adds `Get-PASPTAGlobalCatalog` & `Add-PASPTAGlobalCatalog` commands, available for v13.
- Updates
  - `New-PASSession`
    - Adds Shared Services Auth Support
    - Allows null or empty `OTPDelimiter` to be specified
  - `Set-PASPTARule`
    - Updates validation for parameter `id`
  - `Get-PASComponentDetail`
    - Adds `pta` as option for parameter `component`
  - `Add-PASSafe`
    - Allows `0` as valid value for parameter `NumberOfDaysRetention`
  - `Add-PASSafeMember`
    - Adds optional `memberType` parameter, accepted from 12.6 onward.
- Other
  - Allow UPN UserName format
    - Updates the parameter validation logic of the `*-PASPublicSSHKey` functions to allow UPN style usernames to be specified and accepted.
  - Updates `psPAS.CyberArk.Vault.OnboardingRule` format in line with expected output according to product documentation.
  - Documentation update
    - Correct version requirement information for the `Get-PASAccount` `searchType` parameter.

## **5.4.101 (November 20th 2022)**

- Fix `Get-PASSafeMember`
  - Corrects format of URL value when returning many safe members
    - Thanks [InconstantRO](https://github.com/InconstantRO)!
- Documentation
  - Additional example added to `Get-PASAccount` help file
    - Thanks [rorobig](https://github.com/rorobig)!

## **5.4.94 (September 26th 2022)**

- Breaking Changes
  - `Get-PASAccount`
    - Removes `Gen2Filter` ParameterSet.
    - Equivalent functionality remains available via other available parameters.
  - `Get-PASGroup`
    - Removes `filter` ParameterSet.
    - Equivalent functionality remains available via other available parameters.
- New Commands
  - `Publish-PASDiscoveredAccount`
    - Feature Request: Onboards a discovered account.
    - Based on swagger documentation
  - `Get-PASLinkedAccount`
    - Gets details of linked accounts
  - `Add-PASPersonalAdminAccount`
    - Specific for Adding Personal Admin Accounts in Privilege Cloud.
    - Based on swagger documentation
- Other Updates
  - `New-PASSession`
    - Feature Request: Adds support for PKI Authentication.
  - `Get-PASAccount`
    - Adds `limit` & `offset` parameters.
  - `Get-PASSafe`
    - Corrects ambiguous invocation options (Gen1).
  - Documentation
    - General updates throughout.

## **5.3.76 (August 17th 2022)**

- Updates
  - Set-PASUser / New-PASUser
    - Adds `GUI` as available parameter value for `unAuthorizedInterfaces` parameter.
- Gen1 API Specific
  - Add-PASAccount / Set-PASAccount
    - Fixes enumeration of dynamic properties for Gen1 requests.
  - Reverts Gen1 specific URL update introduced in last release for "_user_" type commands.
    - Removes forward slash (/) to end of request URL

## **5.3.69 (July 26th 2022)**

### Module update to cover all CyberArk 12.6 API features

- New Commands
  - `Enable-PASUser`
    - New command, supported from 12.6
  - `Disable-PASUser`
    - New command, supported from 12.6
- Updates
  - `Get-PASAccount`
    - Added `savedFilter` parameter, supported from 12.6
  - `Get-PASGroup`
    - Added `id` parameter, supported from 12.6
    - Added `groupName` parameter, supported from 12.2.
  - `Get-PASAccountGroup`
    - Depreciated use of "Get Safe account groups" API
    - Makes ParameterSet based on `Get account group by Safe` API the default.
  - Updates URL formatting to include a forward slash (/) to end of URL for functions which may include a dot (.) via provided parameter values.
  - Updated documentation and help text.

## **5.2.59 (November 7th 2021)**

- Fix
  - Resolves issue where `Get-PASSafeMember` would fail with error when using Gen2 API and specifying `MemberName` parameter.
  - Resolves issue where `Set-PASSafe` would fail with error when using Gen2 API.
    - (Thanks [alexR148](https://github.com/alexR148)!).

## **5.2.54 (July 28th 2021)**

- Fix
  - Added `Request-PASJustInTimeAccess` as Exported Function in `psPAS.psd1`.

## **5.2.52 (July 27th 2021)**

### Module update to cover all CyberArk 12.2 API features

- Breaking Changes
  - `Request-PASJustInTimeAccess`
    - Command renamed from `Request-PASAdHocAccess` in line with CyberArk feature nomenclature.
  - `Get-PASSafeMember`
    - Adds capability to get permissions for individual safe member using the Gen2 API from 12.2 onward.
    - Addition of `UseGen1API` parameter allows operation against Gen1 API if required.
  - `Set-PASSafeMember`
    - Adds Gen2 API capability introduced in 12.2.
    - Default operation is now via Gen2 API.
    - Addition of `UseGen1API` parameter allows operation against Gen1 API if required.
  - `Remove-PASSafeMember`
    - Adds support for operation against Gen2 API introduced in PAS 12.2
    - Default operation now requires 12.2
    - `UseGen1API` parameter added to force operation against Gen1 API for earlier PAS versions.
  - `Set-PASSafe`
    - Adds Gen2 API capability introduced in 12.2.
    - Default operation is now via Gen2 API.
    - Addition of `UseGen1API` parameter allows operation against Gen1 API if required.
- New Commands
  - `Get-PASAccountDetail`
    - New experimental function developed using unofficial documentation
  - `Revoke-PASJustInTimeAccess`
    - New API function supported from 12.0 (previously missed)
    - Revokes requested JIT access.
  - `Clear-PASLinkedAccount`
    - Unlinks associated Logon/Reconcile/ExtraPass accounts
  - `Get-PASPlatformSummary`
    - Returns basic platform system type information
- Other Updates
  - `Get-PASSafe`
    - Implements Get Individual Safe details using Gen2 API feature of PAS 12.2.
    - Adds `UseGen1API` parameter to allow backward compatibility when using the `SafeName` parameter.
    - Changes depreciation of Gen1 API operations from 12.2 to 12.3.
  - `Get-PASUser`
    - New `sort` parameter added, supported from 12.2.
    - Added ability to filter by UserName using Gen2 API.
    - Gen1 search by UserName now accessible by also specifying the introduced `UseGen1API` parameter.
  - `Get-PASGroup`
    - New `sort` parameter added, supported from 12.2.
  - `Add-PASGroupMember`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `New-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `Remove-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `Set-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `Unblock-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - Account Methods updated to apply to account details obtained via Gen2 API calls
    - `VerifyPassword()`
      - Updated method to use `Invoke-PASCPMOperation`
    - `ChangePassword()`
      - Updated method to use `Invoke-PASCPMOperation`
    - `ReconcilePassword()`
      - New method using `Invoke-PASCPMOperation`
    - `GetDetails()`
      - New method using `Get-PASAccountDetail`
  - Alias Removal
    - Removed alias values for previously depreciated command names

## **5.1.44 (July 13th 2021)**

- Updates
  - `Get-PASGroup`
    - Added `includeMembers` parameter based on [this article](https://cyberark-customers.force.com/s/article/PVWA-REST-Get-groups-API-does-not-return-members).

## **5.1.37 (June 28th 2021)**

- Updates
  - Resolves issue where the `ConvertTo-UnixTime` helper function provided invalid values when the culture was not 'en-US'.
    - (Thanks [liamwh](https://github.com/liamwh)!).
  - `Set-PASUser`
    - Sets `ValueFromPipelinebyPropertyName = $false` for `ExpiryDate` parameter, avoids parameter validation exception when piping object representing user, such as the output from `Get-PASUSer`, into `Set-PASUser`.
  - `Get-PASAccountPassword`
    - MachineName parameter changed to `string` type (previously was incorrectly specified as `switch`)
    - Added `UserName` parameter & `ToPsCredential()` Method to enable return of Credential Object.
      - (Thanks [zamothh](https://github.com/zamothh)!)

## **5.1.21 (June 7th 2021)**

- Updates
  - `Get-PASSession`
    - Catch errors getting the username of the logged on user so session token and other information can still be extracted from the module scope.
  - `Add-PASSafeMember`
    - Makes `InitiateCPMAccountManagementOperations` non-mandatory; fixes issue introduced in `5.1.16`.
  - `Remove-PASGroupMember`
    - Resolves issue where attempting to remove group member with an '@' symbol in the user name reported a 404 error.
  - `Get-PASPlatform`
    - Fixes issue where expected output was not displayed when using the `platforms` parameterset.

## **5.1.16** (May 23rd 2021)

- Updates
  - `New-PASSession`
    - Introduce support for providing response to RADIUS challenges featuring sub-options.
    - Fixes Gen2 SAML Authentication:
      - Code to get SAML Response via SSO using default credentials updated to correctly format authentication request.
      - `SAMLResponse` Parameter added for user to provide their own SAMLResponse as string value.
  - `Add-PASSafeMember`
    - Fixes issue where some permissions may not be applied when piping object into function and using the Gen2 API.

## **5.0.0** (April 11th 2021)

### Module update to cover all CyberArk 12.0 & 12.1 API features

- Breaking Changes
  - `Get-PASSafeMember`, `Add-PASSafe`, `Get-PASSafe`, `Add-PASSafeMember`, `Remove-PASSafe`
    - Default operation of these functions is now to use the Gen2 API.
    - The `-UseGen1API` Parameter can be specified to force use of the Gen1 API for the following commands:
      - `Get-PASSafeMember`
      - `Add-PASSafeMember`
      - `Add-PASSafe`
      - `Remove-PASSafe`
  - `Find-PASSafe`
    - External changes to the API mean `Find-PASSafe` cannot be used past version 11.7.
    - Equivalent API functionality now exists in `Get-PASSafe` using the Gen2 ParameterSet.
- New Functions For CyberArk Version 12.0:
  - `New-PASAccountPassword`
    - Defines a password value based on the policy for an account
  - `Set-PASGroup`
    - Updates vault groups
- New Functions For CyberArk version 12.1:
  - `Clear-PASDiscoveredAccountList`
    - Clears Pending Accounts List
  - `Get-PASAccountPasswordVersion`
    - Returns details of available password versions
  - `Set-PASLinkedAccount`
    - Associates Linked Logon & Reconcile accounts
  - `New-PASPrivateSSHKey`
    - Generates new MFA Caching Private SSH Key
  - `Remove-PASPrivateSSHKey`
    - Deletes an MFA Caching Private SSH Key
  - `Clear-PASPrivateSSHKey`
    - Removes all MFA Caching Private SSH Keys
- Updated Functions For CyberArk Version 12.0:
  - `Get-PASSafeMember`
    - Updated to use the new Gen2 API endpoint available from version 12.0
    - `MemberName` Parameter depreciated past 12.2
  - `Add-PASSafe`
    - Updated to use the new Gen2 API endpoint available from version 12.0
  - `Get-PASSafe`
    - Updated to use the new Gen2 API endpoint available from version 12.0
- Updated Functions For CyberArk Version 12.1:
  - `Add-PASSafeMember`
    - Updated to use the new Gen2 API endpoint available from version 12.1
    - Gen 1 will not work post 12.2
  - `Get-PASSafeMember`
    - Updated to include new filter parameters available from version 12.1
    - Additional Gen2 Parameters available
  - `Get-PASSafe`
    - Updated to include new Parameter available in 12.1
  - `Remove-PASSafe`
    - Updated to use the new Gen2 API endpoint available from version 12.1
    - Gen 1 will not work post 12.2
  - `Get-PASUser`
    - Updated to include the new `ExtendedDetails` parameter available from version 12.1
    - Additional Gen2 Parameter available
- Other
  - `Get-PASAccount`
    - Removed depreciated Parameter `offset`
    - Removed depreciated Parameter `limit`


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

## **4.4.71** (August 24th 2020)

### Module update to cover all CyberArk 11.6 API features

- New Functions
  - `Start-PASAccountImportJob`
    - Add multiple accounts to existing safes
  - `Get-PASAccountImportJob`
    - Get status of bulk account import jobs
  - `New-PASAccountObject`
    - Formats an object to include in the list of accounts to be added using `Start-PASAccountImportJob`.
  - `Get-PASDiscoveredAccount`
    - Search for and list discovered accounts.
- Updated Functions
  - `Get-PASAccount`
    - Updated to remove repeated code
  - `Add-PASAccount`
    - Updated to use `New-PASAccountObject` to create required request object.
  - `New-PASUser`
    - Updated to remove repeated code
  - `Set-PASUser`
    - Updated to remove repeated code

## **4.3.65** (August 20th 2020)

- Fixes
  - `Get-PASAccount`
    - Fixes issue where no output would be shown if `filter` parameter was used.
  - `Get-PASApplicationAuthenticationMethod`
    - Adds properties `Subject`, `Issuer` & `SubjectAlternativeName` to output view.

## **4.3.62** (August 14th 2020)

- Updated Functions
  - `New-PASRequest`
    - Added Parameters:
      - `AllowMappingLocalDrives`
      - `AllowConnectToConsole`
      - `RedirectSmartCards`
      - `PSMRemoteMachine`
      - `LogonDomain`
      - `AllowSelectHTML5`
    - These are the documented properties expected to be sent as connectionParams.
    - Removes the need for a module user to specify these as a hashtable.
  - `Get-PASAccount`
    - `categoryModificationTime` added to list output
  - `Get-PASUser`
    - Fixed issue where an object with no property values would be returned if no user was found.
  - `Get-PASPTAEvent`
    - Adds parameter `fromUpdateDate`.
    - Removes parameter `UseLegacyMethod`.
    - Lowers required version from 11.4 to 11.3 when using certain parameter combinations.
- Other Fixes & Updates
  - Fixed issue where json displayed in debug output may not have been valid.
  - Updates to codebase and refactored functions to remove repeated code.

## **4.2.26** (July 27th 2020)

### Module update to cover all CyberArk 11.5 API features

- **Behaviour Changes**
  - Renamed `Get-PASPSMConnectionParameter` to `New-PASPSMSession`
- New Functions
  - `Get-PASAllowedReferrer`
    - Lists configured allowed referrers.
    - Requires PAS 11.5
  - `Add-PASAllowedReferrer`
    - Adds a new allowed referrer
    - Requires PAS 11.5
  - `Get-PASAccountSSHKey`
    - Retrieves Private SSH Key of Account
    - Requires PAS 11.5
  - `Get-PASAuthenticationMethod`
    - Lists Authentication method details
    - Requires PAS 11.5
  - `Add-PASAuthenticationMethod`
    - Adds new authentication method
    - Requires PAS 11.5
  - `Set-PASAuthenticationMethod`
    - Updates authentication method
    - Requires PAS 11.5
  - `Get-PASConnectionComponent`
    - Lists all connection components
    - Requires PAS 11.5
  - `Get-PASPSMServer`
    - Lists all configured PSM Servers
    - Requires PAS 11.5
  - `Get-PASPlatformPSMConfig`
    - Returns PSM configuration of Platform
    - Requires PAS 11.5
  - `Set-PASPlatformPSMConfig`
    - Updates PSM configuration of platform
    - Requires PAS 11.5
- Updated Functions
  - `New-PASPSMSession`
    - Removed Parameter: `connectionParams`
    - Added Parameters:
      - `AllowMappingLocalDrives`
      - `AllowConnectToConsole`
      - `RedirectSmartCards`
      - `PSMRemoteMachine`
      - `LogonDomain`
      - `AllowSelectHTML5`
    - These are the documented properties expected to be sent as connectionParams.
    - This update removes the need for a module user to specify these as a hashtable.
  - `Get-PASAccount`
    - Added parameters `safeName` & `modificationTime`.
      - Can be used instead of specifying a correctly formated value for `filter`.
      - `modificationTime` is documented as a valid filter option since 11.4
  - `Get-PASGroup`
    - Adds parameter `groupType`
      - Can be used instead of specifying a correctly formated value for `filter`.
- Other Fixes & Updates
  - `New-PASRequest`
    - Fixed potential issue with date values converted into UNIXTimeStamp.
  - `Get-PASAccount`
    - Fixed potential issue with date values converted into UNIXTimeStamp.
  - `Add-PASDiscoveredAccount`
    - Fixed potential issue with date values converted into UNIXTimeStamp.

## **4.1.11** (July 14th 2020)

### Module update to cover CyberArk 11.5 API features

- **Behaviour Changes**
  - `Get-PASPlatform`
    - When invoked with no parameters to return details of all configured platforms, defaults to operation against the endpoint for the 11.4 API.
    - When invoked with a value provided for the `Active` parameter, will perform operation against the endpoint for the 11.4 API.
    - To utilise the 11.1 api endpoint, a value should be provided for the `PlatformType` and/or `Search` parameters,  or, `Active` and `PlatformType` and/or `Search` parameters.
  - `New-PASSession`
    - Value for OTP will be prompted for if no value is provided for this parameter.
      - The prompt will now relay the text of the response from the RADIUS server.

- New Functions
  - `Copy-PASPlatform`
    - Duplicates target, dependent, group or rotational group platform to a new platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Disable-PASPlatform`
    - Disables, target, group or rotational group platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Enable-PASPlatform`
    - Enables, target, group or rotational group platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Remove-PASPlatform`
    - Deletes, target, dependent, group or rotational group platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Remove-PASGroup`
    - Deletes a specified vault user group
    - 11.5 functionality.

- Updated Functions
  - `Get-PASPlatform`
    - Update to enable query of dependent, group, rotational group platforms
    - Update to include additional filters available for querying target platoforms
    - 11.4 functionality, missed in the `4.0.0` release.
    - Function now defaults to 11.4 target platform endpoint if no parameters are specified.
  - `Get-PASUser`
    - 11.5 output includes group membership details.
    - group membership property may be included in output when function is executed from earlier versions, but its content will be blank.
  - `New-PASSession`
    - OTP can now be omitted entirely from used parameters in scenarios where the value is unknown.
    - Response from RADIUS now used as message for Read-Host prompt for OTP.
    - Depreciated need for use of OTPMode parameter when a prompt for the OTP is required.

- Other Fixes & Updates
  - Documentation updated.
  - Duplicated code for creating the query portion of a URL replaced with new helper function internal to the module.

## **4.0.0** (July 1st 2020)

### Module update to cover CyberArk 11.4 API features

- **Breaking Changes**
  - `Get-PASSafeMember`, `Add-PASSafeMember` & `Set-PASSafeMember`: Output Changed
    - "Permission" property of returned object now contains a nested property=value pair for each permission instead of an array containing only the name of the assigned permissions.
    - Existing scripts which rely on the legacy array value of the `Permissions` property when working with the `*-PASSafeMember` functions must either be updated to work with the new output or use an earlier compatible psPAS version.

- New Function
  - Added `Set-PASPTAEvent`
    - Appeared in 11.3
    - Set status of PTA events

- Updated Functions
  - `New-PASSession`
    - Adds support for updated saml auth updated in 11.4
  - `Get-PASPTAEvent`
    - Adds newly documented parameters for 11.4 and updates request format for filtering events

- Fixes
  - `Set-PASUser`
    - Corrects issue where an incorrectly formed json body was being sent with the request if using the parameters introduced in psPAS 3.3.88.
  - `Add-PASSafeMember` & `Set-PASSafeMember`
    - Update ensures json body of request is always sent with the permission properties statically ordered.

## 3.5.8 (April 2nd 2020)

- Changes minimum required PowerShell version to 5.1
- Updates + Fixes
  - Marginal performance improvement by suppressing progress bar for `Invoke-WebRequest`.
  - `Add-PASAccount`
    - Fixed bug where mandatory username parameter is not sent in the request body when using the classic API.
  - `Get-PASDirectoryMapping`
    - include MappingID in default table output
  - `Get-PASSafeMember`
    - Updated help text to clarify `MemberName` parameter and expected failure conditions due to request method (`PUT` instead of `GET`)

## 3.5.0 (March 15th 2020)

### Module update to cover CyberArk 11.3

- **Breaking Changes**
  - `Add-PASApplicationAuthenticationMethod` - Parameters Changed
    - Removed `AuthName` & `AuthValue` parameters
    - Added named parameters for each authentication type, which accept the `AuthValue` string.
- Updates + Fixes
  - `New-PASSession`
    - Added Parameter `concurrentSession` - supported from 11.3
    - Added support for Windows + RADIUS authentication
    - PSCredential object can now be used for Windows/IIS Authentication.
    - Added logic to prompt for OTP by supplying a value of `passcode` to the `OTP` parameter
  - `Add-PASApplicationAuthenticationMethod`
    - Added support for configuring Certificate Attribute authentication method

## 3.4.100 (January 27th 2020)

### Module update to cover CyberArk 11.2 API features

- **Breaking Changes**
  - Parameters Changed: `New-PASDirectoryMapping` & `Set-PASDirectoryMapping`
    - Functions updated to use enum flag for mapping authorization options
    - `MappingAuthorizations`
      - Parameter now accepts string values representing the authorizations to configure for the mapping instead of an integer representation of them.
    - The following parameters are no longer accepted by the functions, the string values must now be provided to the `MappingAuthorizations` parameter instead:
      - `AddUpdateUsers`
      - `AddSafes`
      - `AddNetworkAreas`
      - `ManageServerFileCategories`
      - `AuditUsers`
      - `BackupAllSafes`
      - `RestoreAllSafes`
      - `ResetUsersPasswords`
      - `ActivateUsers`

- New Function
  - Added `Test-PASPSMRecording`
    - New in 11.2

- Fixes & Other Updates
  - Update `Get-PASAccount` to accept `searchType` parameter. Relevant to 11.2+.
  - Fixed incorrectly declared mandatory parameter in `Set-PASUser`
    - No longer required to set new password on user update.
  - Update `psPAS.CyberArk.Vault.User.Formats`
    - Include expiry & last logon date in friendly format.
    - New table format for displaying user information returned from API requests.
  - Performance related updates to internal module mechanics.
  - All functions help text updated to include link to function documentation on <https://pspas.pspete.dev>
  - Corrections & updates to documentation on <https://pspas.pspete.dev>

## 3.3.88 (December 13th 2019)

### Module update to cover CyberArk 11.1 API features

- New Functions
  - `New-PASGroup`
    - Creates CyberArk Groups
    - Requires 11.1
  - `Get-PASPlatformSafe`
    - List safes by platform id
    - Requires 11.1
  - `Remove-PASDirectoryMapping`
    - Delete Directory Mappings
    - Requires 11.1
  - `Enable-PASCPMAutoManagement`
    - Enable Automatic CPM Management for an Account.
    - Requires 10.4+
  - `Disable-PASCPMAutoManagement`
    - Disable Automatic CPM Management for an Account.
    - Requires 10.4+

- Updated Functions
  - `Set-PASDirectoryMapping`
    - MappingAuthorizations parameter no longer accepts pipeline input
  - `Add-PASDiscoveredAccount`
    - Added features introduced in version 10.8
    - Supports Account Dependency & AWS specific parameters
  - `Get-PASPlatform`s
    - Added features introduced in version 11.1
    - New options for finding platforms
  - `Remove-PASUser`
    - Added features introduced in version 11.1
    - Delete User by ID
  - `Set-PASUser`
    - Added features introduced in version 11.1
    - Expanded options for updating users.
  - `New-PASSession`
    - Added `Certificate` parameter to allow specification of a client certificate to be used for a secure web request.

- Fixes & Other Updates
  - `Get-PASAccountPassword`
    - Fixed incorrectly escaped value for passwords beginning with "\"
  - `New-PASRequest`
    - Fixed incorrect parameter name which prevented requests specifying multiple access as required being created.
  - Error Reporting
    - Added more verbose error messages.

## 3.2.37 (Sept 17th 2019)

- Update Format for `psPAS.CyberArk.Vault.User`
  - Change default displayed properties when searching users with V10 API.

## 3.2.34 (Sept 11th 2019)

- Minor updates to Help Text.
  - Clarified version requirements for parameters & api capabilities.

## 3.2.32 (Sept 5th 2019)

- Fixes
  - `Add-PASSafeMember`
    - Update validation of MemberName parameter to not accept values containing `&` symbol.

## 3.2.30 (Sept 1st 2019)

- Update
  - Raise minimum required PowerShell version to 5.0.

## 3.2.27 (Sept 1st 2019)

- Updates
  - `New-PASSession`
    - Adds support for sending OTP in response to RADIUS Challenge
    - Adds support to skip certificate validation

- Fixes
  - `Get-PASAccountPassword`
    - Parameter name corrected to `TicketingSystem` from `TicketingSystemName`

## 3.1.13 (July 19th 2019)

- Fixes
  - `New-PASSession`
    - Fixes issue where authentication token was not available to other module functions after authenticating via the v10 API endpoint from CyberArk v9.X.

## 3.1.10 (July 16th 2019)

- Fixes
  - `Set-PASAccount`
    - Fixes non-terminating error when not piping an object into the function and using the Classic API.

## 3.1.7 (July 13th 2019)

- Updates
  - `Add-PASSafeMember`
    - Added parameter aliases for permission name equivalent names returned from Get-PASSafeMember.
  - `Get-PASSafeMember`
    - Updated help text to detail permission name equivalents returned from the API.

## 3.1.0 (July 7th 2019)

### Module update to cover CyberArk 10.10 API features

- New Functions
  - `Set-PASUserPassword`
    - Reset user passwords
  - `Set-PASDirectoryMappingOrder`
    - Reorder directory mappings
- Updated Functions
  - `New-PASDirectoryMapping`
    - Added parameter `UserActivityLogPeriod` for 10.10 API
  - `Set-PASDirectoryMapping`
    - Added parameter `UserActivityLogPeriod` for 10.10 API
  - `Get-PASUser`
    - Added parameter `id` for 10.10 API
  - `Unblock-PASUser`
    - Added parameter `id` for 10.10 API endpoint

## **3.0.0** (July 1st 2019)

_2 years since first commit Anniversary Edition_

- Breaking Changes
  - Module Wide Parameter Changes
    - `BaseURI`, `WebSession`, `PVWAAppName`, `SessionToken`, `ExternalVersion`
      - no longer required parameters.
      - `New-PASSession` still requires `BaseURI`, and will accept `PVWAAppName`
    - `UseV9API` & `UseV10API` Parameters renamed to `UseClassicAPI`
      - Where functions support operations against both Classic & V10 API, default behaviour is to use the V10 API.
      - Specify the `UseClassicAPI` switch parameter to force usage of the Classic API Endpoint.
    - Values for `BaseURI`, `WebSession`, `PVWAAppName`, `SessionToken` & `ExternalVersion` are not returned from module functions in output.
  - Functions Removed
    - `New-PASSAMLSession`
      - Functionality moved into `New-PASSession`.
    - `New-PASSharedSession`
      - Functionality moved into `New-PASSession`.
    - `Close-PASSAMLSession`
      - Functionality moved into `Close-PASSession`.
    - `Close-PASSharedSession`
      - Functionality moved into `Close-PASSession`.
    - `Start-PASCredChange`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Start-PASCredVerify`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Invoke-PASCredChange`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Invoke-PASCredVerify`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Invoke-PASCredReconcile`
      - Functionality moved into `Invoke-PASCPMOperation`.
  - Aliases Removed
    - `Get-PASApplications` - Removed old pluralised alias
    - `Get-PASApplicationAuthenticationMethods` - Removed old pluralised alias
    - `Get-PASAccountCredentials` - Removed old pluralised alias
    - `Get-PASSafeMembers` - Removed old pluralised alias
- New Functions
  - `Find-PASSafe` (Thanks (again) [steveredden](https://github.com/steveredden)!)
    - List or search safes by name
  - `Invoke-PASCPMOperation`
    - Invoke CPM Verify, Change & Reconcile via v10 or Classic API.
  - `Get-PASSession`
    - Return module scope variable values which are used to perform each request to the API.
  - `Use-PASSession`
    - Set module scope variable values which are used to perform each request to the API.
- Updated Functions
  - `New-PASSession`
    - Added `CertificateThumbprint` Parameter
      - Allows requests to be sent with details required for Client Certificate authentication.
    - Added `OTP` Parameter
      - Allows One Time Passcode to be provided, which is then sent with the password value.
        - Tested with Duo RADIUS.
    - Added SAML authentication option.
    - Added Shared authentication option
    - Removed `$SecureMode` & `$AdditionalInfo` parameters.
  - `Get-PASPSMConnectionParameter`
    - Now saves an RDP file returned from an API request.
    - `path` parameter now expects a folder to save the file to.
    - Output file is named automatically
  - `Export-PASPlatform`
    - `path` parameter now expects a folder to save the file to.
    - Output file is named automatically
  - `Export-PASPSMRecording`
    - `path` parameter now expects a folder to save the file to.
    - Output file is named automatically
- Fixes
  - `New-PASUser`
    - Added `ChangePassOnNextLogon` parameter for working with latest API method
    - Fixes issue where `New-PASUser` was failing to set the change password at next logon flag for a new user.
- Other
  - Improvements to exception handling and error reporting.

## 2.6.17 (May 16th 2019)

- Fix
  - `Add-PASDirectory`
    - Parameter `SSLConnect` added (required if adding LDAPS hosts)
    - Thanks (again) [jmk-foofus](https://github.com/jmk-foofus)!

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
  - Remove debug output which could contain plaintext passwords.
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
    - Enables request of temporary administrative access to a server.
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
