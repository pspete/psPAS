---
title: "Compatibility"
permalink: /docs/compatibility/
excerpt: "Module Compatibility"
last_modified_at: 2023-03-06T01:23:45-00:00
toc: false
---

This section lists the commands available in psPAS as well as any relevant version requirements.

Depending on your version of CyberArk, different psPAS commands and parameters are available.

The most recent psPAS version should work with your particular CyberArk version and be able to be used with it.

The version requirements for certain parameters are described in greater detail in the command's documentation.

## Function List

Check the below table to determine what functions are available for you to use:

The minimum required version of CyberArk to use the function is listed.
{: .notice--info}

CyberArk Version may affect available capabilities or function parameters. See [Notes](#notes) for more details.
{: .notice--warning}

The module will take steps to verify that your version of CyberArk meets any psPAS command's minimum version requirement.

If version requirement criteria are not met, operations may be prevented.
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
[`Get-PASAccountDetail`][Get-PASAccountDetail]                                           |**10.4**                                            |Returns information about accounts.
[`Get-PASAccountActivity`][Get-PASAccountActivity]                                       |**9.7**                                             |Returns activities for an account.
[`Get-PASAccountPassword`][Get-PASAccountPassword]                                       |**9.7** ([Notes](#get-pasaccountpassword))          |Returns password for an account.
[`Remove-PASAccount`][Remove-PASAccount]                                                 |**9.3** ([Notes](#remove-pasaccount))               |Deletes an account
[`Set-PASAccount`][Set-PASAccount]                                                       |**9.5** ([Notes](#set-pasaccount))                  |Updates details of an account.
[`Invoke-PASCPMOperation`][Invoke-PASCPMOperation]                                       |**9.7** ([Notes](#invoke-pascpmoperation))          |Invoke CPM verify, change & reconcile tasks.
[`Unlock-PASAccount`][Unlock-PASAccount]                                                 |**9.10**([Notes](#unlock-pasaccount))               |Checks-in / Unlocks an exclusive-use account.
[`Add-PASApplication`][Add-PASApplication]                                               |**9.1**                                             |Adds a new application
[`Add-PASApplicationAuthenticationMethod`][Add-PASApplicationAuthenticationMethod]       |**9.1**                                             |Add authentication method to an application
[`Get-PASApplication`][Get-PASApplication]                                               |**9.1**                                             |Returns details of applications
[`Get-PASApplicationAuthenticationMethod`][Get-PASApplicationAuthenticationMethod]       |**9.1**                                             |Returns application authentication methods
[`Remove-PASApplication`][Remove-PASApplication]                                         |**9.1**                                             |Deletes an application
[`Remove-PASApplicationAuthenticationMethod`][Remove-PASApplicationAuthenticationMethod] |**9.1**                                             |Delete auth method from an application
[`Import-PASConnectionComponent`][Import-PASConnectionComponent]                         |**10.3**                                            |Imports a Connection Component
[`New-PASPSMSession`][New-PASPSMSession]                                                 |**9.10** ([Notes](#New-PASPSMSession))  |Get required parameters to connect through PSM
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
[`Add-PASSafeMember`][Add-PASSafeMember]                                                 |**9.3** ([Notes](#add-passafemember))               |Adds a Safe Member to a safe
[`Get-PASSafeMember`][Get-PASSafeMember]                                                 |**9.7** ([Notes](#get-passafemember))               |Lists the members of a Safe
[`Remove-PASSafeMember`][Remove-PASSafeMember]                                           |**9.3** ([Notes](#remove-passafemember)             |Removes a member from a safe
[`Set-PASSafeMember`][Set-PASSafeMember]                                                 |**9.3** ([Notes](#set-passafemember)                |Updates a Safe Member's Permissions
[`Add-PASSafe`][Add-PASSafe]                                                             | **9.2** ([Notes](#add-passafe))                    |Adds a new safe
[`Get-PASSafe`][Get-PASSafe]                                                             | **9.7** ([Notes](#get-passafe))                    |Returns safe details
[`Remove-PASSafe`][Remove-PASSafe]                                                       | **9.3** ([Notes](#remove-passafe))                 |Deletes a safe
[`Set-PASSafe`][Set-PASSafe]                                                             | **9.3** ([Notes](#set-passafe))                    |Updates a safe
[`Get-PASSafeShareLogo`][Get-PASSafeShareLogo]                                           | **9.7**                                            |Returns details of SafeShare Logo
[`Get-PASServer`][Get-PASServer]                                                         | **9.7**                                            |Returns details of the Web Service Server
[`Get-PASServerWebService`][Get-PASServerWebService]                                     | **9.7**                                            |Returns details of the Web Service
[`Get-PASComponentDetail`][Get-PASComponentDetail]                                       | **10.1** ([Notes](#get-pascomponentdetail))        |Returns details about component instances.
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
[`Get-PASGroup`][Get-PASGroup]                                                           | **10.5** ([Notes](#get-pasgroup))                  |Return group information
[`Remove-PASGroupMember`][Remove-PASGroupMember]                                         | **10.5**                                           |Remove group members
[`Set-PASOnboardingRule`][Set-PASOnboardingRule]                                         | **10.5**                                           |Update Onboarding Rules
[`Add-PASDiscoveredAccount`][Add-PASDiscoveredAccount]                                   | **10.5** ([Notes](#add-pasdiscoveredaccount))      |Add discovered accounts to the Accounts Feed
[`Connect-PASPSMSession`][Connect-PASPSMSession]                                         | **10.5**                                           |Get required parameters to connect to a PSM Session
[`Get-PASPSMSessionActivity`][Get-PASPSMSessionActivity]                                 | **10.6**                                           |Get activity details from an active PSM Session.
[`Get-PASPSMSessionProperty`][Get-PASPSMSessionProperty]                                 | **10.6**                                           |Get property details from an active PSM Session.
[`Get-PASPSMRecordingActivity`][Get-PASPSMRecordingActivity]                             | **10.6**                                           |Get activity details from a PSM Recording.
[`Get-PASPSMRecordingProperty`][Get-PASPSMRecordingProperty]                             | **10.6**                                           |Get property details from a PSM Recording.
[`Export-PASPSMRecording`][Export-PASPSMRecording]                                       | **10.6**                                           |Save PSM Session Recording to a file.
[`Request-PASJustInTimeAccess`][Request-PASJustInTimeAccess]                             | **10.6**                                           |Request temporary access to a server.
[`Revoke-PASJustInTimeAccess`][Revoke-PASJustInTimeAccess]                               | **12.0**                                           |Revoke temporary server access.
[`Get-PASDirectoryMapping`][Get-PASDirectoryMapping]                                     | **10.7**                                           |Get details of configured directory mappings.
[`Set-PASDirectoryMapping`][Set-PASDirectoryMapping]                                     | **10.7** ([Notes](#set-pasdirectorymapping))       |Update a configured directory mapping.
[`Remove-PASDirectory`][Remove-PASDirectory]                                             | **10.7**                                           |Delete a directory configuration.
[`Find-PASSafe`][Find-PASSafe]                                                           | **10.1** - **11.7** ([Notes](#find-passafe))       |List or Search Safes by name.
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
[`Get-PASAllowedReferrer`][Get-PASAllowedReferrer]                                       |**11.5**                                            |List PVWA Allowed Referrer
[`Add-PASAllowedReferrer`][Add-PASAllowedReferrer]                                       |**11.5**                                            |Add PVWA Allowed Referrer
[`Get-PASAccountSSHKey`][Get-PASAccountSSHKey]                                           |**11.5**                                            |Get Private SSH Key value of Account
[`Get-PASAuthenticationMethod`][Get-PASAuthenticationMethod]                             |**11.5**                                            |List authentication methods
[`Add-PASAuthenticationMethod`][Add-PASAuthenticationMethod]                             |**11.5**                                            |Add authentication method
[`Set-PASAuthenticationMethod`][Set-PASAuthenticationMethod]                             |**11.5**                                            |Update authentication method
[`Get-PASConnectionComponent`][Get-PASConnectionComponent]                               |**11.5**                                            |List configured connection components
[`Get-PASPSMServer`][Get-PASPSMServer]                                                   |**11.5**                                            |List configured PSM Servers
[`Get-PASPlatformPSMConfig`][Get-PASPlatformPSMConfig]                                   |**11.5**                                            |List Platform PSM configuration
[`Set-PASPlatformPSMConfig`][Set-PASPlatformPSMConfig]                                   |**11.5**                                            |Update Platform PSM configuration
[`Start-PASAccountImportJob`][Start-PASAccountImportJob]                                 |**11.6**                                            |Add multiple accounts to existing Safes.
[`Get-PASAccountImportJob`][Get-PASAccountImportJob]                                     |**11.6**                                            |Get status of account import
[`New-PASAccountObject`][New-PASAccountObject]                                           |**---**                                             |Format an object to include in an import list
[`Get-PASDiscoveredAccount`][Get-PASDiscoveredAccount]                                   |**11.6**                                            |List discovered accounts
[`Add-PASOpenIDConnectProvider`][Add-PASOpenIDConnectProvider]                           |**11.7**                                            |Adds an OIDC Authentication Provider
[`Get-PASOpenIDConnectProvider`][Get-PASOpenIDConnectProvider]                           |**11.7**                                            |Gets details of configured OIDC Authentication Providers
[`Remove-PASOpenIDConnectProvider`][Remove-PASOpenIDConnectProvider]                     |**11.7**                                            |Deletes an OIDC Authentication Provider
[`Set-PASOpenIDConnectProvider`][Set-PASOpenIDConnectProvider]                           |**11.7**                                            |Updates an OIDC Authentication Provider
[`Remove-PASAuthenticationMethod`][Remove-PASAuthenticationMethod]                       |**11.7**                                            |Delete an authentication method
[`Clear-PASDiscoveredAccountList`][Clear-PASDiscoveredAccountList]                       |**12.1**                                            |Clear all discovered accounts from the pending account list
[`Get-PASAccountPasswordVersion`][Get-PASAccountPasswordVersion]                         |**12.1**                                            |Get details of previous password versions
[`New-PASAccountPassword`][New-PASAccountPassword]                                       |**12.0**                                            |Generate new password values based on platform policy
[`Set-PASLinkedAccount`][Set-PASLinkedAccount]                                           |**12.1**                                            |Associate logon and reconcile accounts
[`Clear-PASLinkedAccount`][Clear-PASLinkedAccount]                                       |**12.2**                                            |Clear associated linked accounts
[`Clear-PASPrivateSSHKey`][Clear-PASPrivateSSHKey]                                       |**12.1**                                            |Remove all MFA caching SSH Keys
[`New-PASPrivateSSHKey`][New-PASPrivateSSHKey]                                           |**12.1**                                            |Generate MFA caching SSH Keys
[`Remove-PASPrivateSSHKey`][Remove-PASPrivateSSHKey]                                     |**12.1**                                            |Delete MFA caching SSH Keys
[`Set-PASGroup`][Set-PASGroup]                                                           |**12.0**                                            |Update CyberArk groups
[`Get-PASPlatformSummary`][Get-PASPlatformSummary]                                       |**12.2**                                            |Get basic information on current platform system types
[`Enable-PASUser`][Enable-PASUser]                                                       |**12.6**                                            |Enable CyberArk Users
[`Disable-PASUser`][Disable-PASUser]                                                     |**12.6**                                            |Disable CyberArk Users
[`Publish-PASDiscoveredAccount`][Publish-PASDiscoveredAccount]                           |**12.6**                                            |Onboard Discovered Accounts
[`Get-PASLinkedAccount`][Get-PASLinkedAccount]                                           |**12.2**                                            |Get details of linked accounts
[`Get-PASLinkedGroup`][Get-PASLinkedGroup]                                               |**12.2**                                            |Get details of linked groups
[`Add-PASPersonalAdminAccount`][Add-PASPersonalAdminAccount]                             |**12.6**                                            |Add Personal Admin Account (Privilege Cloud Only).
[`Get-PASPTAGlobalCatalog`][Get-PASPTAGlobalCatalog]                                     |**13.0**                                            |Get Global Catalog connectivity details for PTA.
[`Add-PASPTAGlobalCatalog`][Add-PASPTAGlobalCatalog]                                     |**13.0**                                            |Add Global Catalog connectivity details to PTA.
[`Get-PASUserTypeInfo`][Get-PASUserTypeInfo]                                             |**13.2**                                            |Get User Type Info
[`Get-PASPTARiskEvent`][Get-PASPTARiskEvent]                                             |**13.2** ([Notes](#get-pasptariskevent))            |Get PTA Risk Events
[`Set-PASPTARiskEvent`][Set-PASPTARiskEvent]                                             |**13.2** ([Notes](#set-pasptariskevent))            |Update PTA Risk Events
[`Get-PASPTARiskSummary`][Get-PASPTARiskSummary]                                         |**13.2**                                            |Get PTA Risk Summary
[`New-PASRequestObject`][New-PASRequestObject]                                           |**---**                                             |Format an object to include in an request list
[`Add-PASPTAExcludedTarget`][Add-PASPTAExcludedTarget]                                   |**14.0**                                             |Excludes a PTA Monitored Target
[`Add-PASPTAIncludedTarget`][Add-PASPTAIncludedTarget]                                   |**14.0**                                             |Includes a PTA Monitored Target
[`Add-PASPTAPrivilegedGroup`][Add-PASPTAPrivilegedGroup]                                 |**14.0**                                             |Configures a PTA Privileged Group
[`Add-PASPTAPrivilegedUser`][Add-PASPTAPrivilegedUser]                                   |**14.0**                                             |Configures a PTA Privileged User
[`Get-PASPTAExcludedTarget`][Get-PASPTAExcludedTarget]                                   |**14.0**                                             |Get PTA Excluded Target
[`Get-PASPTAIncludedTarget`][Get-PASPTAIncludedTarget]                                   |**14.0**                                             |Get PTA Included target
[`Get-PASPTAPrivilegedGroup`][Get-PASPTAPrivilegedGroup]                                 |**14.0**                                             |Get PTA Privileged Group
[`Get-PASPTAPrivilegedUser`][Get-PASPTAPrivilegedUser]                                   |**14.0**                                             |Get PTA Privileged User
[`Remove-PASPTAExcludedTarget`][Remove-PASPTAExcludedTarget]                             |**14.0**                                             |Remove PTA Excluded Target
[`Remove-PASPTAIncludedTarget`][Remove-PASPTAIncludedTarget]                             |**14.0**                                             |Remove PTA Included Target
[`Remove-PASPTAPrivilegedGroup`][Remove-PASPTAPrivilegedGroup]                           |**14.0**                                             |Remove PTA Privileged Group
[`Remove-PASPTAPrivilegedUser`][Remove-PASPTAPrivilegedUser]                             |**14.0**                                             |Remove PTA Privileged User
[`Set-PASIPAllowList`][Set-PASIPAllowList]                                               |**P Cloud Only**                                     |Set P Cloud IP Allow List
[`Get-PASIPAllowList`][Get-PASIPAllowList]                                               |**P Cloud Only**                                     |Get P Cloud IP Allow List
[`Get-PASBYOKConfig`][Get-PASBYOKConfig]                                                 |**P Cloud Only**                                     |Get P Cloud BYOK Config
[`Publish-PASDiscoveredLocalAccount`][Publish-PASDiscoveredLocalAccount]                 |**P Cloud Only**                                     |Publish P Cloud Discovered Local Account
[`Remove-PASDiscoveredLocalAccount`][Remove-PASDiscoveredLocalAccount]                   |**P Cloud Only**                                     |Delete  P Cloud Discovered Local Account
[`Get-PASDiscoveredLocalAccountActivity`][Get-PASDiscoveredLocalAccountActivity]         |**P Cloud Only**                                     |Get  P Cloud Discovered Local Account Activity
[`Get-PASDiscoveredLocalAccount`][Get-PASDiscoveredLocalAccount]                         |**P Cloud Only**                                     |Get  P Cloud Discovered Local Account
[`Clear-PASDiscoveredLocalAccount`][Clear-PASDiscoveredLocalAccount]                     |**P Cloud Only**                                     |Clear all  P Cloud Discovered Local Accounts
[`Add-PASDiscoveredLocalAccount`][Add-PASDiscoveredLocalAccount]                         |**P Cloud Only**                                     |Add  P Cloud Discovered Local Account

[Get-PASIPAllowList]:/commands/Get-PASIPAllowList
[Set-PASIPAllowList]:/commands/Set-PASIPAllowList
[Get-PASBYOKConfig]:/commands/Get-PASBYOKConfig
[Publish-PASDiscoveredLocalAccount]:/commands/Publish-PASDiscoveredLocalAccount
[Get-PASDiscoveredLocalAccountActivity]:/commands/Get-PASDiscoveredLocalAccountActivity
[Get-PASDiscoveredLocalAccount]:/commands/Get-PASDiscoveredLocalAccount
[Clear-PASDiscoveredLocalAccount]:/commands/Clear-PASDiscoveredLocalAccount
[Add-PASDiscoveredLocalAccount]:/commands/Add-PASDiscoveredLocalAccount
[Remove-PASDiscoveredLocalAccount]:/commands/Remove-PASDiscoveredLocalAccount
[Add-PASPTAExcludedTarget]:/commands/Add-PASPTAExcludedTarget
[Add-PASPTAIncludedTarget]:/commands/Add-PASPTAIncludedTarget
[Add-PASPTAPrivilegedGroup]:/commands/Add-PASPTAPrivilegedGroup
[Add-PASPTAPrivilegedUser]:/commands/Add-PASPTAPrivilegedUser
[Get-PASPTAExcludedTarget]:/commands/Get-PASPTAExcludedTarget
[Get-PASPTAIncludedTarget]:/commands/Get-PASPTAIncludedTarget
[Get-PASPTAPrivilegedGroup]:/commands/Get-PASPTAPrivilegedGroup
[Get-PASPTAPrivilegedUser]:/commands/Get-PASPTAPrivilegedUser
[Remove-PASPTAExcludedTarget]:/commands/Remove-PASPTAExcludedTarget
[Remove-PASPTAIncludedTarget]:/commands/Remove-PASPTAIncludedTarget
[Remove-PASPTAPrivilegedGroup]:/commands/Remove-PASPTAPrivilegedGroup
[Remove-PASPTAPrivilegedUser]:/commands/Remove-PASPTAPrivilegedUser
[New-PASRequestObject]:/commands/New-PASRequestObject
[Get-PASUserTypeInfo]:/commands/Get-PASUserTypeInfo
[Get-PASPTARiskEvent]:/commands/Get-PASPTARiskEvent
[Set-PASPTARiskEvent]:/commands/Set-PASPTARiskEvent
[Get-PASPTARiskSummary]:/commands/Get-PASPTARiskSummary
[Get-PASPTAGlobalCatalog]:/commands/Get-PASPTAGlobalCatalog
[Add-PASPTAGlobalCatalog]:/commands/Add-PASPTAGlobalCatalog
[Get-PASLinkedAccount]:/commands/Get-PASLinkedAccount
[Get-PASLinkedGroup]:/commands/Get-PASLinkedGroup
[Add-PASPersonalAdminAccount]:/commands/Add-PASPersonalAdminAccount
[Publish-PASDiscoveredAccount]:/commands/Publish-PASDiscoveredAccount
[Enable-PASUser]:/commands/Enable-PASUser
[Disable-PASUser]:/commands/Disable-PASUser
[Get-PASPlatformSummary]:/commands/Get-PASPlatformSummary
[Clear-PASDiscoveredAccountList]:/commands/Clear-PASDiscoveredAccountList
[Get-PASAccountPasswordVersion]:/commands/Get-PASAccountPasswordVersion
[New-PASAccountPassword]:/commands/New-PASAccountPassword
[Set-PASLinkedAccount]:/commands/Set-PASLinkedAccount
[Clear-PASLinkedAccount]:/commands/Clear-PASLinkedAccount
[Clear-PASPrivateSSHKey]:/commands/Clear-PASPrivateSSHKey
[New-PASPrivateSSHKey]:/commands/New-PASPrivateSSHKey
[Remove-PASPrivateSSHKey]:/commands/Remove-PASPrivateSSHKey
[Set-PASGroup]:/commands/Set-PASGroup
[Add-PASOpenIDConnectProvider]:/commands/Add-PASOpenIDConnectProvider
[Get-PASOpenIDConnectProvider]:/commands/Get-PASOpenIDConnectProvider
[Remove-PASOpenIDConnectProvider]:/commands/Remove-PASOpenIDConnectProvider
[Set-PASOpenIDConnectProvider]:/commands/Set-PASOpenIDConnectProvider
[Remove-PASAuthenticationMethod]:/commands/Remove-PASAuthenticationMethod
[Get-PASDiscoveredAccount]:/commands/Get-PASDiscoveredAccount
[Start-PASAccountImportJob]:/commands/Start-PASAccountImportJob
[Get-PASAccountImportJob]:/commands/Get-PASAccountImportJob
[New-PASAccountObject]:/commands/New-PASAccountObject
[Get-PASAllowedReferrer]:/commands/Get-PASAllowedReferrer
[Add-PASAllowedReferrer]:/commands/Add-PASAllowedReferrer
[Get-PASAccountSSHKey]:/commands/Get-PASAccountSSHKey
[Get-PASAuthenticationMethod]:/commands/Get-PASAuthenticationMethod
[Add-PASAuthenticationMethod]:/commands/Add-PASAuthenticationMethod
[Set-PASAuthenticationMethod]:/commands/Set-PASAuthenticationMethod
[Get-PASConnectionComponent]:/commands/Get-PASConnectionComponent
[Get-PASPSMServer]:/commands/Get-PASPSMServer
[Get-PASPlatformPSMConfig]:/commands/Get-PASPlatformPSMConfig
[Set-PASPlatformPSMConfig]:/commands/Set-PASPlatformPSMConfig
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
[New-PASPSMSession]:/commands/New-PASPSMSession
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
[Request-PASJustInTimeAccess]:/commands/Request-PASJustInTimeAccess
[Revoke-PASJustInTimeAccess]:/commands/Revoke-PASJustInTimeAccess
[Get-PASDirectoryMapping]:/commands/Get-PASDirectoryMapping
[Set-PASDirectoryMapping]:/commands/Set-PASDirectoryMapping
[Remove-PASDirectory]:/commands/Remove-PASDirectory
[Find-PASSafe]:/commands/Find-PASSafe
[Invoke-PASCPMOperation]:/commands/Invoke-PASCPMOperation
[Set-PASDirectoryMappingOrder]:/commands/Set-PASDirectoryMappingOrder
[Set-PASUserPassword]:/commands/Set-PASUserPassword
[Disable-PASCPMAutoManagement]:/commands/Disable-PASCPMAutoManagement
[Enable-PASCPMAutoManagement]:/commands/Enable-PASCPMAutoManagement
[Remove-PASDirectoryMapping]:/commands/Remove-PASDirectoryMapping
[Get-PASPlatformSafe]:/commands/Get-PASPlatformSafe
[New-PASGroup]:/commands/New-PASGroup
[Test-PASPSMRecording]:/commands/Test-PASPSMRecording
[Copy-PASPlatform]:/commands/Copy-PASPlatform
[Disable-PASPlatform]:/commands/Disable-PASPlatform
[Enable-PASPlatform]:/commands/Enable-PASPlatform
[Remove-PASPlatform]:/commands/Remove-PASPlatform
[Remove-PASGroup]:/commands/Remove-PASGroup
[Get-PASAccountDetail]:/commands/Get-PASAccountDetail

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
- The Gen1 API endpoint can be used by specifying the `-UseGen1API` parameter.

### Close-PASSession

- The Gen1 API endpoint can be used by specifying the `-UseGen1API` parameter.

### Get-PASAccountGroup

- Version 10.5 introduced a new API endpoint, "Get Safe account groups".
  - This API is deprecated from version 12.6.
  - The "Get Safe account groups" API endpoint can be used by specifying the `-UseGen1API` parameter.

### Add-PASAccount

- Version 10.4 introduced a new API endpoint.
- The Gen1 API endpoint can be used by using the ParameterSet which includes the  `-password` parameter.

### Get-PASAccount

- 12.6 introduced ability to use the `savedFilter` parameter
- 11.4 introduced ability to filter by modificationTime
- Version 10.4 introduced a new API endpoint.
  - Supports:
    - Get details of all matching accounts.
- The Gen1 API endpoint can be used by using the `-Keywords` & `-Safe` parameters.
  - The Gen1 API is limited to returning the details of only 1 account.

### Get-PASAccountPassword

- Version 10.1 introduced a new API endpoint.
  - Supports:
    - Specifying Reason for Access.
    - Supplying Ticketing Information.
    - Requesting specific password versions.
    - Return of SSH key.

### Remove-PASAccount

- Version 10.4 introduced a new API endpoint.
- The Gen1 API endpoint can be used by specifying the `-UseGen1API` parameter.

### Set-PASAccount

- Version 10.4 introduced a new API endpoint.
  - Supports:
    - Add/Update/Remove single account property.
    - Perform multiple update operations against account.
  - Requires Parameters:
    - `op` (for single property update)
    - `operations` (for multiple updates)
- The Gen1 API endpoint requires all of the account properties be passed to the function.
  - Any current properties of the account not sent as part of the request will result in them being removed from the account.

### Invoke-PASCPMOperation

- Version 9.10 introduced a new API endpoint.
  - Supports:
    - Verify/Change/Reconcile of password.
- Version 10.1 introduced a new API endpoint.
  - Supports:
    - Changing password to specific value.
    - Changing password only in the vault.
- The Gen1 API endpoint can be used by:
  - Using the `-ImmediateChangeByCPM` parameter.
  - Specifying the `-UseGen1API` parameter.

### New-PASPSMSession

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
- `New-PASRequest`
  - Version 13.2 introduced a new API endpoint.
  - Supports:
    - Requests to access multiple accounts
- `Get-PASRequest`
  - Version 13.2 introduced a new API endpoint.
  - Supports:
    - Get status of requests to access multiple accounts

### Add-PASGroupMember

- Version 10.6 introduced a new API endpoint.
  - Requires Parameters:
    - `GroupID`
    - `memberID`
- The Gen1 API endpoint can be used by using the `GroupName` & `UserName` parameters.
- Gen1 API deprecated from 12.3

### Get-PASUser

- Version 10.9 introduced a new API endpoint.
  - Supports:
    - Additional query types.
- Version 10.10 introduced a new API endpoint.
  - Supports:
    - Get user by ID.
- Version 11.5 returns additional group membership  detail for user accounts.
- Version 12.1 introduced new parameter to request `ExtendedDetails` for a user.
- Version 12.2 introduced new `sort` parameter and ability to filter by UserName.
- Version 13.2 introduced new `source` & `userStatus` parameters.

### New-PASUser

- Version 10.9 introduced a new API endpoint.
  - Supports:
    - Additional property parameters.
- Gen1 API deprecated from 12.3
- Version 13.2 introduced new parameters: `userActivityLogRetentionDays`, `loginFromHour` & `loginToHour`

### Unblock-PASUser

- Version 10.10 introduced a new API endpoint.
  - Requires Parameters:
    - `userID`
- The Gen1 API endpoint can be used by using the `userName` parameter.
- Gen1 API deprecated from 12.3

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

- Version 14.0 introduced new API parameters.
  - Supports:
    - `UsedQuota`
    - `AuthorizedInterfaces`
    - `EnableENEWhenDisconnected`

### Set-PASDirectoryMapping

- Version 10.10 introduced a new API endpoint.
  - Supports:
    - `UserActivityLogPeriod`.

- Version 14.0 introduced new API parameters.
  - Supports:
    - `UsedQuota`
    - `AuthorizedInterfaces`
    - `EnableENEWhenDisconnected`

### Add-PASDiscoveredAccount

- Version 10.8 introduced a new API endpoint.
  - Supports:
    - Account Dependency & AWS specific parameters
- Version 11.7
  - Supports
    - Azure specific parameter

### Get-PASPlatform

- Version 11.1 introduced a new API endpoint.
  - Supports:
    - New options for finding platforms
- Version 11.4 introduced new API endpoints
  - Parameters added to enable more filtering options for querying target platforms
  - Parameters added to request details of dependent, group & rotational group platforms.
- Version 9.10+  When specifying PlatformID
  - if the platform properties contain a semicolon (';'), the API may not return the complete value.
    - noted for ChangeCommand, ReconcileCommand & ConnectionCommand properties

### Remove-PASUser

- Version 11.1 introduced a new API endpoint.
  - Supports:
    - Delete User by ID
- Gen1 API deprecated from 12.3

### Set-PASUser

- Version 11.1 introduced a new API endpoint.
  - Supports:
    - Additional parameters for updating users.
- Gen1 API deprecated from 12.3
- Version 13.2 introduced new parameters: `userActivityLogRetentionDays`, `loginFromHour` & `loginToHour`

### Get-PASPTAEvent

- Version 11.3 introduced new parameters for filtering events
  - Supports:
    - status
    - fromUpdateDate
- Version 11.4 introduced new parameters for filtering events
  - Supports:
    - accountID

### Get-PASSafeMember

- Version 12.0 introduced a new API endpoint.
- Version 12.1 introduced new filter parameters.
- Version 12.2 introduces capability to get permissions of individual safe member.

### Set-PASSafeMember

- Version 12.2 introduced a new API endpoint.

### Remove-PASSafeMember

- Version 12.2 introduced a new API endpoint.

### Add-PASSafeMember

- Version 12.1 introduced a new API endpoint.

### Add-PASSafe

- Version 12.0 introduced a new API endpoint.

### Get-PASSafe

- Version 12.0 introduced a new API endpoint.
- Version 12.1 introduced a new parameter `extendedDetails`.
- Version 12.1 introduces capability to get details of individual safe using the Gen2 API.

### Remove-PASSafe

- Version 12.1 introduced a new API endpoint.

### Find-PASSafe

- External changes to the API mean `Find-PASSafe` cannot be used past version 11.7.
- Equivalent API functionality exists in `Get-PASSafe` using the `Gen2` ParameterSet.

### Get-PASGroup

- Version 12.0 introduced `includeMembers` parameter.
- Version 12.2 introduced new `sort` & `groupName` parameters.
- Version 12.6 introduced the `id` parameter.

### Set-PASSafe

- Version 12.2 introduced new API endpoint

### Get-PASComponentDetail

- Version 12 adds pta as target component

### Unlock-PASAccount

- Unlock (not check-in) assumed to work from 11.6 (officially supported from 14.0)

### Get-PASPTARiskEvent

- Version 14 introduced new filter parameters
  - `FromTime`
  - `ToTime`

### Set-PASPTARiskEvent

- Version 14 introduced new parameters
  - `closeReason`
  - `reasonText`