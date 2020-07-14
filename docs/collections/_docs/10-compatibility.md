---
title: "Compatibility"
permalink: /docs/compatibility/
excerpt: "Module Compatibility"
last_modified_at: 2020-07-12zT01:33:52-00:00
toc: false
---

Your version of CyberArk determines which functions of psPAS will be supported.

## Function List

Check the below table to determine what functions are available for you to use:

The CyberArk Version listed is the minimum required to use the function.
{: .notice--info}

CyberArk Version may affect available capabilities or function parameters. See [Notes](#notes) for more details.
{: .notice--warning}

If you are using version 9.7+, and the function being invoked requires version 9.8+, psPAS will attempt to confirm that your version of CyberArk meets the minimum version requirement.
{: .notice--success}

**Function Name**                                                                        | **CyberArk Version**                               | **Description**
---------------------------------------------------------------------------------------- | -------------------------------------------------- | :----------------
[`New-PASSession`][New-PASSession]                                                       | **9.0** ([Notes](#new-passession))                 |Authenticates a user to CyberArk Vault
[`Close-PASSession`][Close-PASSession]                                                   | **9.0** ([Notes](#close-passession))               |Logoff from CyberArk Vault.
[`Get-PASSession`][Get-PASSession]                                                       | **---**                                            |Get `psPAS` Session Data.
[`Use-PASSession`][Use-PASSession]                                                       | **---**                                            |Set `psPAS` Session Data.
[`Add-PASPublicSSHKey`][Add-PASPublicSSHKey]                                             | **9.6**                                            |Adds an authorised public SSH key for a user.
[`Get-PASPublicSSHKey`][Get-PASPublicSSHKey]                                             | **9.6**                                            |Retrieves a user's SSH Keys.
[`Remove-PASPublicSSHKey`][Remove-PASPublicSSHKey]                                       |**9.6**                                             |Deletes a Public SSH Key from a user
[`Add-PASAccountACL`][Add-PASAccountACL]                                                 |**9.0**                                             |Adds a new privileged command rule to an account.
[`Get-PASAccountACL`][Get-PASAccountACL]                                                 |**9.0**                                             |Lists privileged commands rule for an account
[`Remove-PASAccountACL`][Remove-PASAccountACL]                                           |**9.0**                                             |Deletes privileged commands rule from an account
[`Add-PASAccountGroupMember`][Add-PASAccountGroupMember]                                 |**9.95**                                            |Adds an account as a member of an account group.
[`Get-PASAccountGroup`][Get-PASAccountGroup]                                             |**9.10** ([Notes](#get-pasaccountgroup))            |Returns account groups in a Safe.
[`Get-PASAccountGroupMember`][Get-PASAccountGroupMember]                                 |**9.10**                                            |Returns  members of an account group.
[`New-PASAccountGroup`][New-PASAccountGroup]                                             |**9.95**                                            |Adds a new account group
[`Remove-PASAccountGroupMember`][Remove-PASAccountGroupMember]                           |**9.10**                                            |Deletes a member of an account group
[`Add-PASAccount`][Add-PASAccount]                                                       |**9.0** ([Notes](#add-pasaccount))                  |Adds a new account.
[`Add-PASPendingAccount`][Add-PASPendingAccount]                                         |**9.7**                                             |Adds discovered account or SSH key as a pending account.
[`Get-PASAccount`][Get-PASAccount]                                                       |**9.3** ([Notes](#get-pasaccount))                  |Returns information about accounts.
[`Get-PASAccountActivity`][Get-PASAccountActivity]                                       |**9.7**                                             |Returns activities for an account.
[`Get-PASAccountPassword`][Get-PASAccountPassword]                                       |**9.7** ([Notes](#get-pasaccountpassword))          |Returns password for an account.
[`Remove-PASAccount`][Remove-PASAccount]                                                 |**9.3** ([Notes](#remove-pasaccount))               |Deletes an account
[`Set-PASAccount`][Set-PASAccount]                                                       |**9.5** ([Notes](#set-pasaccount))                  |Updates details of an account.
[`Invoke-PASCPMOperation`][Invoke-PASCPMOperation]                                       |**9.7** ([Notes](#invoke-pascpmoperation))          |Invoke CPM verify, change & reconcile tasks.
[`Unlock-PASAccount`][Unlock-PASAccount]                                                 |**9.10**                                            |Checks in an exclusive-use account.
[`Add-PASApplication`][Add-PASApplication]                                               |**9.1**                                             |Adds a new application
[`Add-PASApplicationAuthenticationMethod`][Add-PASApplicationAuthenticationMethod]       |**9.1**                                             |Add authentication method to an application
[`Get-PASApplication`][Get-PASApplication]                                               |**9.1**                                             |Returns details of applications
[`Get-PASApplicationAuthenticationMethod`][Get-PASApplicationAuthenticationMethod]       |**9.1**                                             |Returns application authentication methods
[`Remove-PASApplication`][Remove-PASApplication]                                         |**9.1**                                             |Deletes an application
[`Remove-PASApplicationAuthenticationMethod`][Remove-PASApplicationAuthenticationMethod] |**9.1**                                             |Delete auth method from an application
[`Import-PASConnectionComponent`][Import-PASConnectionComponent]                         |**10.3**                                            |Imports a Connection Component
[`Get-PASPSMConnectionParameter`][Get-PASPSMConnectionParameter]                         |**9.10** ([Notes](#get-paspsmConnectionparameter))  |Get required parameters to connect through PSM
[`Get-PASPSMRecording`][Get-PASPSMRecording]                                             |**9.10** ([Notes](#get-paspsmrecording))            |Get details of PSM Recording
[`Get-PASPSMSession`][Get-PASPSMSession]                                                 |**9.10** ([Notes](#get-paspsmsession))              |Get details of PSM Sessions
[`Resume-PASPSMSession`][Resume-PASPSMSession]                                           |**10.2**                                            |Resumes a Suspended PSM Session.
[`Stop-PASPSMSession`][Stop-PASPSMSession]                                               |**10.1**                                            |Terminates a PSM Session.
[`Suspend-PASPSMSession`][Suspend-PASPSMSession]                                         |**10.2**                                            |Suspends a PSM Session.
[`Get-PASOnboardingRule`][Get-PASOnboardingRule]                                         |**9.7**                                             |Gets automatic on-boarding rules
[`New-PASOnboardingRule`][New-PASOnboardingRule]                                         |**9.7** ([Notes](#new-pasonboardingrule))           |Adds a new on-boarding rule
[`Remove-PASOnboardingRule`][Remove-PASOnboardingRule]                                   |**9.7**                                             |Deletes an automatic on-boarding rule
[`Get-PASPlatform`][Get-PASPlatform]                                                     |**9.10** ([Notes](#get-pasplatform))                |Retrieves details of a specified platform.
[`Import-PASPlatform`][Import-PASPlatform]                                               |**10.2**                                            |Import a new platform
[`Export-PASPlatform`][Export-PASPlatform]                                               |**10.4**                                            |Export a  platform
[`Add-PASPolicyACL`][Add-PASPolicyACL]                                                   |**9.0**                                             |Adds a new privileged command rule
[`Get-PASPolicyACL`][Get-PASPolicyACL]                                                   |**9.0**                                             |Lists OPM Rules for a policy
[`Remove-PASPolicyACL`][Remove-PASPolicyACL]                                             |**9.0**                                             |Delete privileged commands from policy
[`Approve-PASRequest`][Approve-PASRequest]                                               |**9.10** ([Notes](#-pasrequest))                    |Confirm a single request
[`Deny-PASRequest`][Deny-PASRequest]                                                     |**9.10** ([Notes](#-pasrequest))                    |Reject a single request
[`Get-PASRequest`][Get-PASRequest]                                                       |**9.10** ([Notes](#-pasrequest))                    |List requests
[`Get-PASRequestDetail`][Get-PASRequestDetail]                                           |**9.10** ([Notes](#-pasrequestdetail))              |Get request details
[`New-PASRequest`][New-PASRequest]                                                       |**9.10** ([Notes](#-pasrequest))                    |Creates an access request for an account
[`Remove-PASRequest`][Remove-PASRequest]                                                 |**9.10** ([Notes](#-pasrequest))                    |Deletes a request
[`Add-PASSafeMember`][Add-PASSafeMember]                                                 |**9.3**                                             |Adds a Safe Member to a safe
[`Get-PASSafeMember`][Get-PASSafeMember]                                                 |**9.7**                                             |Lists the members of a Safe
[`Remove-PASSafeMember`][Remove-PASSafeMember]                                           |**9.3**                                             |Removes a member from a safe
[`Set-PASSafeMember`][Set-PASSafeMember]                                                 |**9.3**                                             |Updates a Safe Member's Permissions
[`Add-PASSafe`][Add-PASSafe]                                                             | **9.2**                                            |Adds a new safe
[`Get-PASSafe`][Get-PASSafe]                                                             | **9.7**                                            |Returns safe details
[`Remove-PASSafe`][Remove-PASSafe]                                                       | **9.3**                                            |Deletes a safe
[`Set-PASSafe`][Set-PASSafe]                                                             | **9.3**                                            |Updates a safe
[`Get-PASSafeShareLogo`][Get-PASSafeShareLogo]                                           | **9.7**                                            |Returns details of SafeShare Logo
[`Get-PASServer`][Get-PASServer]                                                         | **9.7**                                            |Returns details of the Web Service Server
[`Get-PASServerWebService`][Get-PASServerWebService]                                     | **9.7**                                            |Returns details of the Web Service
[`Get-PASComponentDetail`][Get-PASComponentDetail]                                       | **10.1**                                           |Returns details about component instances.
[`Get-PASComponentSummary`][Get-PASComponentSummary]                                     | **10.1**                                           |Returns consolidated information about components.
[`Add-PASGroupMember`][Add-PASGroupMember]                                               | **9.7** ([Notes](#add-pasgroupmember))             |Adds a user as a group member
[`Get-PASLoggedOnUser`][Get-PASLoggedOnUser]                                             | **9.7**                                            |Returns details of the logged on user
[`Get-PASUserLoginInfo`][Get-PASUserLoginInfo]                                           | **10.4**                                           |Returns login details of the current user
[`Get-PASUser`][Get-PASUser]                                                             | **9.7** ([Notes](#get-pasuser))                    |Returns details of a user
[`New-PASUser`][New-PASUser]                                                             | **9.7** ([Notes](#new-pasuser))                    |Creates a new user
[`Remove-PASUser`][Remove-PASUser]                                                       | **9.7** ([Notes](#remove-pasuser))                 |Deletes a user
[`Set-PASUser`][Set-PASUser]                                                             | **9.7** ([Notes](#set-pasuser))                    |Updates a user
[`Unblock-PASUser`][Unblock-PASUser]                                                     | **9.7** ([Notes](#unblock-pasuser))                |Activates a suspended user
[`Get-PASDirectory`][Get-PASDirectory]                                                   | **10.4** ([Notes](#get-pasdirectory))              |Get configured LDAP directories
[`Add-PASDirectory`][Add-PASDirectory]                                                   | **10.4** ([Notes](#add-pasdirectory))              |Add a new LDAP directory
[`New-PASDirectoryMapping`][New-PASDirectoryMapping]                                     | **10.4** ([Notes](#new-pasdirectorymapping))       |Create a new LDAP directory mapping
[`Add-PASPTARule`][Add-PASPTARule]                                                       | **10.4**                                           |Add a new Risky Commandrule to PTA
[`Get-PASPTAEvent`][Get-PASPTAEvent]                                                     | **10.3**                                           |Get security events from PTA
[`Set-PASPTAEvent`][Set-PASPTAEvent]                                                     | **11.3**                                           |Set status of PTA security events
[`Get-PASPTARemediation`][Get-PASPTARemediation]                                         | **10.4**                                           |Get automatic response config from PTA
[`Get-PASPTARule`][Get-PASPTARule]                                                       | **10.4**                                           |List Risky Command rules from PTA
[`Set-PASPTARemediation`][Set-PASPTARemediation]                                         | **10.4**                                           |Update automaticresponse config in PTA
[`Set-PASPTARule`][Set-PASPTARule]                                                       | **10.4**                                           |Update a Risky Commandrule in PTA
[`Get-PASGroup`][Get-PASGroup]                                                           | **10.5**                                           |Return group information
[`Remove-PASGroupMember`][Remove-PASGroupMember]                                         | **10.5**                                           |Remove group members
[`Set-PASOnboardingRule`][Set-PASOnboardingRule]                                         | **10.5**                                           |Update Onboarding Rules
[`Add-PASDiscoveredAccount`][Add-PASDiscoveredAccount]                                   | **10.5** ([Notes](#add-pasdiscoveredaccount))      |Add discovered accounts to the Accounts Feed
[`Connect-PASPSMSession`][Connect-PASPSMSession]                                         | **10.5**                                           |Get required parameters to connect to a PSM Session
[`Get-PASPSMSessionActivity`][Get-PASPSMSessionActivity]                                 | **10.6**                                           |Get activity details from an active PSM Session.
[`Get-PASPSMSessionProperty`][Get-PASPSMSessionProperty]                                 | **10.6**                                           |Get property details from an active PSM Session.
[`Get-PASPSMRecordingActivity`][Get-PASPSMRecordingActivity]                             | **10.6**                                           |Get activity details from a PSM Recording.
[`Get-PASPSMRecordingProperty`][Get-PASPSMRecordingProperty]                             | **10.6**                                           |Get property details from a PSM Recording.
[`Export-PASPSMRecording`][Export-PASPSMRecording]                                       | **10.6**                                           |Save PSM Session Recording to a file.
[`Request-PASAdHocAccess`][Request-PASAdHocAccess]                                       | **10.6**                                           |Request temporary access to a server.
[`Get-PASDirectoryMapping`][Get-PASDirectoryMapping]                                     | **10.7**                                           |Get details of configured directory mappings.
[`Set-PASDirectoryMapping`][Set-PASDirectoryMapping]                                     | **10.7** ([Notes](#set-pasdirectorymapping))       |Update a configured directory mapping.
[`Remove-PASDirectory`][Remove-PASDirectory]                                             | **10.7**                                           |Delete a directory configuration.
[`Find-PASSafe`][Find-PASSafe]                                                           | **10.1**                                           |List or Search Safes by name.
[`Set-PASDirectoryMappingOrder`][Set-PASDirectoryMappingOrder]                           | **10.10**                                          |Reorder Directory Mappings
[`Set-PASUserPassword`][Set-PASUserPassword]                                             | **10.10**                                          |Reset a User's Password
[`New-PASGroup`][New-PASGroup]                                                           | **11.1**                                           |Create a new CyberArk group
[`Get-PASPlatformSafe`][Get-PASPlatformSafe]                                             | **11.1**                                           |List details for all platforms
[`Remove-PASDirectoryMapping`][Remove-PASDirectoryMapping]                               | **11.1**                                           |Deletes a Directory Mapping
[`Enable-PASCPMAutoManagement`][Enable-PASCPMAutoManagement]                             | **10.4**                                           |Enables Automatic CPM Management for an account
[`Disable-PASCPMAutoManagement`][Disable-PASCPMAutoManagement]                           | **10.4**                                           |Disables Automatic CPM Management for an account
[`Test-PASPSMRecording`][Test-PASPSMRecording]                                           | **11.2**                                           |Determine validity of PSM Session Recording
[`Copy-PASPlatform`][Copy-PASPlatform]                                                   |**11.4**                                            |Duplicate a platform
[`Enable-PASPlatform`][Enable-PASPlatform]                                               |**11.4**                                            |Enable a platform
[`Disable-PASPlatform`][Disable-PASPlatform]                                             |**11.4**                                            |Disable a platform
[`Remove-PASPlatform`][Remove-PASPlatform]                                               |**11.4**                                            |Delete a platform
[`Remove-PASGroup`][Remove-PASGroup]                                                     |**11.5**                                            |Delete a user group

[New-PASSession]:/commands/New-PASSession
[Close-PASSession]:/commands/Close-PASSession
[Get-PASSession]:/commands/Get-PASSession
[Use-PASSession]:/commands/Use-PASSession
[Add-PASPublicSSHKey]:/commands/Add-PASPublicSSHKey
[Get-PASPublicSSHKey]:/commands/Get-PASPublicSSHKey
[Remove-PASPublicSSHKey]:/commands/Remove-PASPublicSSHKey
[Add-PASAccountACL]:/commands/Add-PASAccountACL
[Get-PASAccountACL]:/commands/Get-PASAccountACL
[Remove-PASAccountACL]:/commands/Remove-PASAccountACL
[Add-PASAccountGroupMember]:/commands/Add-PASAccountGroupMember
[Get-PASAccountGroup]:/commands/Get-PASAccountGroup
[Get-PASAccountGroupMember]:/commands/Get-PASAccountGroupMember
[New-PASAccountGroup]:/commands/New-PASAccountGroup
[Remove-PASAccountGroupMember]:/commands/Remove-PASAccountGroupMember
[Add-PASAccount]:/commands/Add-PASAccount
[Add-PASPendingAccount]:/commands/Add-PASPendingAccount
[Get-PASAccount]:/commands/Get-PASAccount
[Get-PASAccountActivity]:/commands/Get-PASAccountActivity
[Get-PASAccountPassword]:/commands/Get-PASAccountPassword
[Remove-PASAccount]:/commands/Remove-PASAccount
[Set-PASAccount]:/commands/Set-PASAccount
[Unlock-PASAccount]:/commands/Unlock-PASAccount
[Add-PASApplication]:/commands/Add-PASApplication
[Add-PASApplicationAuthenticationMethod]:/commands/Add-PASApplicationAuthenticationMethod
[Get-PASApplication]:/commands/Get-PASApplication
[Get-PASApplicationAuthenticationMethod]:/commands/Get-PASApplicationAuthenticationMethod
[Remove-PASApplication]:/commands/Remove-PASApplication
[Remove-PASApplicationAuthenticationMethod]:/commands/Remove-PASApplicationAuthenticationMethod
[Import-PASConnectionComponent]:/commands/Import-PASConnectionComponent
[Get-PASPSMConnectionParameter]:/commands/Get-PASPSMConnectionParameter
[Get-PASPSMRecording]:/commands/Get-PASPSMRecording
[Get-PASPSMSession]:/commands/Get-PASPSMSession
[Resume-PASPSMSession]:/commands/Resume-PASPSMSession
[Stop-PASPSMSession]:/commands/Stop-PASPSMSession
[Suspend-PASPSMSession]:/commands/Suspend-PASPSMSession
[Get-PASOnboardingRule]:/commands/Get-PASOnboardingRule
[New-PASOnboardingRule]:/commands/New-PASOnboardingRule
[Remove-PASOnboardingRule]:/commands/Remove-PASOnboardingRule
[Get-PASPlatform]:/commands/Get-PASPlatform
[Import-PASPlatform]:/commands/Import-PASPlatform
[Export-PASPlatform]:/commands/Export-PASPlatform
[Add-PASPolicyACL]:/commands/Add-PASPolicyACL
[Get-PASPolicyACL]:/commands/Get-PASPolicyACL
[Remove-PASPolicyACL]:/commands/Remove-PASPolicyACL
[Approve-PASRequest]:/commands/Approve-PASRequest
[Deny-PASRequest]:/commands/Deny-PASRequest
[Get-PASRequest]:/commands/Get-PASRequest
[Get-PASRequestDetail]:/commands/Get-PASRequestDetail
[New-PASRequest]:/commands/New-PASRequest
[Remove-PASRequest]:/commands/Remove-PASRequest
[Add-PASSafeMember]:/commands/Add-PASSafeMember
[Get-PASSafeMember]:/commands/Get-PASSafeMember
[Remove-PASSafeMember]:/commands/Remove-PASSafeMember
[Set-PASSafeMember]:/commands/Set-PASSafeMember
[Add-PASSafe]:/commands/Add-PASSafe
[Get-PASSafe]:/commands/Get-PASSafe
[Remove-PASSafe]:/commands/Remove-PASSafe
[Set-PASSafe]:/commands/Set-PASSafe
[Get-PASSafeShareLogo]:/commands/Get-PASSafeShareLogo
[Get-PASServer]:/commands/Get-PASServer
[Get-PASServerWebService]:/commands/Get-PASServerWebService
[Get-PASComponentDetail]:/commands/Get-PASComponentDetail
[Get-PASComponentSummary]:/commands/Get-PASComponentSummary
[Add-PASGroupMember]:/commands/Add-PASGroupMember
[Get-PASLoggedOnUser]:/commands/Get-PASLoggedOnUser
[Get-PASUserLoginInfo]:/commands/Get-PASUserLoginInfo
[Get-PASUser]:/commands/Get-PASUser
[New-PASUser]:/commands/New-PASUser
[Remove-PASUser]:/commands/Remove-PASUser
[Set-PASUser]:/commands/Set-PASUser
[Unblock-PASUser]:/commands/Unblock-PASUser
[Get-PASDirectory]:/commands/Get-PASDirectory
[Add-PASDirectory]:/commands/Add-PASDirectory
[New-PASDirectoryMapping]:/commands/New-PASDirectoryMapping
[Add-PASPTARule]:/commands/Add-PASPTARule
[Get-PASPTAEvent]:/commands/Get-PASPTAEvent
[Set-PASPTAEvent]:/commands/Set-PASPTAEvent
[Get-PASPTARemediation]:/commands/Get-PASPTARemediation
[Get-PASPTARule]:/commands/Get-PASPTARule
[Set-PASPTARemediation]:/commands/Set-PASPTARemediation
[Set-PASPTARule]:/commands/Set-PASPTARule
[Get-PASGroup]:/commands/Get-PASGroup
[Remove-PASGroupMember]:/commands/Remove-PASGroupMember
[Set-PASOnboardingRule]:/commands/Set-PASOnboardingRule
[Add-PASDiscoveredAccount]:/commands/Add-PASDiscoveredAccount
[Connect-PASPSMSession]:/commands/Connect-PASPSMSession
[Get-PASPSMSessionActivity]:/commands/Get-PASPSMSessionActivity
[Get-PASPSMSessionProperty]:/commands/Get-PASPSMSessionProperty
[Get-PASPSMRecordingActivity]:/commands/Get-PASPSMRecordingActivity
[Get-PASPSMRecordingProperty]:/commands/Get-PASPSMRecordingProperty
[Export-PASPSMRecording]:/commands/Export-PASPSMRecording
[Request-PASAdHocAccess]:/commands/Request-PASAdHocAccess
[Get-PASDirectoryMapping]:/commands/Get-PASDirectoryMapping
[Set-PASDirectoryMapping]:/commands/Set-PASDirectoryMapping
[Remove-PASDirectory]:/commands/Remove-PASDirectory
[Find-PASSafe]:/commands/Find-PASSafe
[Invoke-PASCPMOperation]:/commands/Invoke-PASCPMOperation
[Set-PASDirectoryMappingOrder]:/commands/Set-PASDirectoryMappingOrder
[Set-PASUserPassword]:/commands/Set-PASUserPassword
[Disable-PASCPMAutoManagement]:/commands/Disable-PASCPMAutoManagement.ps1
[Enable-PASCPMAutoManagement]:/commands/Enable-PASCPMAutoManagement.ps1
[Remove-PASDirectoryMapping]:/commands/Remove-PASDirectoryMapping.ps1
[Get-PASPlatformSafe]:/commands/Get-PASPlatformSafe.ps1
[New-PASGroup]:/commands/New-PASGroup.ps1
[Test-PASPSMRecording]:/commands/Test-PASPSMRecording.ps1
[Copy-PASPlatform]:/commands/Copy-PASPlatform.ps1
[Disable-PASPlatform]:/commands/Disable-PASPlatform.ps1
[Enable-PASPlatform]:/commands/Enable-PASPlatform.ps1
[Remove-PASPlatform]:/commands/Remove-PASPlatform.ps1
[Remove-PASGroup]:/commands/Remove-PASGroup.ps1

## Notes

### New-PASSession

- Version 9.7 introduced a new Authentication Options:
  - New Authentication Methods:
    - LDAP
    - RADIUS
    - Shared
    - SAML
- Version 10.4 introduced a new Authentication Option.
  - New Authentication Method:
    - Windows
- Version 11.3 introduced support for concurrent API sessions.
- Version 11.4 introduced updated support for SAML auth.
- The Classic API endpoint can be used by specifying the `-UseClassicAPI` parameter.

### Close-PASSession

- The Classic API endpoint can be used by specifying the `-UseClassicAPI` parameter.

### Get-PASAccountGroup

- Version 10.5 introduced a new API endpoint.
- The Classic API endpoint can be used by specifying the `-UseClassicAPI` parameter.

### Add-PASAccount

- Version 10.4 introduced a new API endpoint.
- The Classic API endpoint can be used by using the ParameterSet which includes the  `-password` parameter.

### Get-PASAccount

- Version 10.4 introduced a new API endpoint.
  - Supports:
    - Get details of all matching accounts.
- The Classic API endpoint can be used by using the `-Keywords` & `-Safe` parameters.
  - The Classic API is limited to returning the details of only 1 account.

### Get-PASAccountPassword

- Version 10.1 introduced a new API endpoint.
  - Supports:
    - Specifying Reason for Access.
    - Supplying Ticketing Information.
    - Requesting specific password versions.
    - Return of SSH key.

### Remove-PASAccount

- Version 10.4 introduced a new API endpoint.
- The Classic API endpoint can be used by specifying the `-UseClassicAPI` parameter.

### Set-PASAccount

- Version 10.4 introduced a new API endpoint.
  - Supports:
    - Add/Update/Remove single account property.
    - Perform multiple update operations against account.
  - Requires Parameters:
    - `op` (for single property update)
    - `operations` (for multiple updates)
- The Classic API endpoint requires all of the account properties be passed to the function.
  - Any current properties of the account not sent as part of the request will result in them being removed from the account.

### Invoke-PASCPMOperation

- Version 9.10 introduced a new API endpoint.
  - Supports:
    - Verify/Change/Reconcile of password.
- Version 10.1 introduced a new API endpoint.
  - Supports:
    - Changing password to specific value.
    - Changing password only in the vault.
- The Classic API endpoint can be used by:
  - Using the `-ImmediateChangeByCPM` parameter.
  - Specifying the `-UseClassicAPI` parameter.

### Get-PASPSMConnectionParameter

- Version 10.2 introduced a new API endpoint.
  - Supports:
    - Connection via PSM GW.
- Version 10.5 introduced a new API endpoint.
  - Supports:
    - AdHoc Connect.

### Get-PASPSMRecording

- Version 10.6 introduced a new API endpoint.
  - Supports:
    - Get recording details by `RecordingID`.

### Get-PASPSMSession

- Version 10.6 introduced a new API endpoint.
  - Supports:
    - Get session details by `liveSessionId`.

### New-PASOnboardingRule

- Version 10.2 introduced a new API endpoint.
  - Supports:
    - Additional filter options
  - Requires Parameters:
    - `DecisionSafeName`
    - `DecisionPlatformId`

### `*-PASRequest`*

- The functions related to requests (`Approve-PASRequest`, `Deny-PASRequest`, `Get-PASRequest`, `Get-PASRequestDetail`, `New-PASRequest` & `Remove-PASRequest`), are documented as supported from version 9.10.
  - Reports received from `psPAS` users, observing that these functions also work in version 9.9.

### Add-PASGroupMember

- Version 10.6 introduced a new API endpoint.
  - Requires Parameters:
    - `GroupID`
    - `UserID`
- The Classic API endpoint can be used by using the `GroupName` & `UserName` parameters.

### Get-PASUser

- Version 10.9 introduced a new API endpoint.
  - Supports:
    - Additional query types.
- Version 10.10 introduced a new API endpoint.
  - Supports:
    - Get user by ID.
- Version 11.5 returns additional group membership  detail for user accounts.

### New-PASUser

- Version 10.9 introduced a new API endpoint.
  - Supports:
    - Additional property parameters.

### Unblock-PASUser

- Version 10.10 introduced a new API endpoint.
  - Requires Parameters:
    - `userID`
- The Classic API endpoint can be used by using the `userName` parameter.

### Get-PASDirectory

- Version 10.5 introduced a new API endpoint.
  - Supports:
    - Get directory details by id.

### Add-PASDirectory

- Version 10.7 introduced a new API endpoint.
  - Requires Parameters:
    - `DCList` Parameter.

### New-PASDirectoryMapping

- Version 10.7 introduced a new API endpoint.
  - Supports:
    - `VaultGroups`.
    - `Location`.
    - `LDAP Query`.

- Version 10.10 introduced a new API endpoint.
  - Supports:
    - `UserActivityLogPeriod`.

### Set-PASDirectoryMapping

- Version 10.10 introduced a new API endpoint.
  - Supports:
    - `UserActivityLogPeriod`.

### Add-PASDiscoveredAccount

- Version 10.8 introduced a new API endpoint.
  - Supports:
    - Account Dependancy & AWS specific parameters

### Get-PASPlatform

- Version 11.1 introduced a new API endpoint.
  - Supports:
    - New options for finding platforms
- Version 11.4 introduced new API endpoints
  - Parameters added to enable more filtering options for querying target platforms
  - Parameters addded to request details of dependent, group & rotational group platforms.

### Remove-PASUser

- Version 11.1 introduced a new API endpoint.
  - Supports:
    - Delete User by ID

### Set-PASUser

- Version 11.1 introduced a new API endpoint.
  - Supports:
    - Additional parameters for updating users.

### Get-PASPTAEvent

- Version 11.4 introduced new parameters for filtering events
  - Supports:
    - status
    - accountID
