---
title: "psPAS + API Command Reference"
permalink: /commands/
excerpt: "Command Reference"
last_modified_at: 2023-03-06T01:23:45-00:00
toc: false
layout: single-mod
classes: wide
author_profile: false
share: false
sidebar:
  nav: "commands"
---

In the table below, links to the official vendor documentation for the API commands are included alongside links to the documentation for related functions in the psPAS module.

Some API commands are combined into single psPAS commands.
{: .notice--warning}
Some API commands are split into multiple psPAS commands.
{: .notice--warning}
A psPAS command may not appear in the below list due to it not being explicitly developed against a native API command.
{: .notice--info}

**API Command**                                                                             | **psPAS Command**                                 |
------------------------------------------------------------------------------------------- | -------------------------------------------------- |
[CyberArk, LDAP, Radius, Windows Logon][CyberArk, LDAP, Radius, Windows Logon]              | [New-PASSession][New-PASSession]
[SAML Logon][SAML Logon]                                                                    | [New-PASSession][New-PASSession]
[Shared Logon authentication][Shared Logon authentication]                                  | [New-PASSession][New-PASSession]
[CyberArk, LDAP, Radius, Windows Logoff][CyberArk, LDAP, Radius, Windows Logoff]            | [Close-PASSession][Close-PASSession]
[Shared Logon Authentication Logoff][Shared Logon Authentication Logoff]                    | [Close-PASSession][Close-PASSession]
[Get accounts][Get accounts]                                                                | [Get-PASAccount][Get-PASAccount]
[Get account details][Get account details]                                                  | [Get-PASAccount][Get-PASAccount]
[Add account][Add account]                                                                  | [Add-PASAccount][Add-PASAccount]
[Update account][Update account]                                                            | [Set-PASAccount][Set-PASAccount]
[Delete account][Delete account]                                                            | [Remove-PASAccount][Remove-PASAccount]
[Check in an exclusive account][Check in an exclusive account]                              | [Unlock-PASAccount][Unlock-PASAccount]
[Get OPM account commands][Get OPM account commands]                                        | [Get-PASAccountACL][Get-PASAccountACL]
[Add OPM account commands][Add OPM account commands]                                        | [Add-PASAccountACL][Add-PASAccountACL]
[Delete OPM account commands][Delete OPM account commands]                                  | [Remove-PASAccountACL][Remove-PASAccountACL]
[Get account activity][Get account activity]                                                | [Get-PASAccountActivity][Get-PASAccountActivity]
[Get Safe account groups][Get Safe account groups]                                          | [Get-PASAccountGroup][Get-PASAccountGroup]
[Get account group by Safe][Get account group by Safe]                                      | [Get-PASAccountGroup][Get-PASAccountGroup]
[Add account group][Add account group]                                                      | [New-PASAccountGroup][New-PASAccountGroup]
[Get account group members][Get account group members]                                      | [Get-PASAccountGroupMember][Get-PASAccountGroupMember]
[Add member to account group][Add member to account group]                                  | [Add-PASAccountGroupMember][Add-PASAccountGroupMember]
[Delete member from account group][Delete member from account group]                        | [Remove-PASAccountGroupMember][Remove-PASAccountGroupMember]
[Create bulk upload of accounts][Create bulk upload of accounts]                            | [Start-PASAccountImportJob][Start-PASAccountImportJob]
[Get all bulk account uploads for user][Get all bulk account uploads for user]              | [Get-PASAccountImportJob][Get-PASAccountImportJob]
[Get bulk account upload result][Get bulk account upload result]                            | [Get-PASAccountImportJob][Get-PASAccountImportJob]
[Get password value][Get password value]                                                    | [Get-PASAccountPassword][Get-PASAccountPassword]
[Retrieve private SSH key account][Retrieve private SSH key account]                        | [Get-PASAccountSSHKey][Get-PASAccountSSHKey]
[Get Just in Time access][Get Just in Time access]                                          | [Request-PASJustInTimeAccess][Request-PASJustInTimeAccess]
[Revoke Just in Time access][Revoke Just in Time access]                                    | [Revoke-PASJustInTimeAccess][Revoke-PASJustInTimeAccess]
[Add allowed referrer][Add allowed referrer]                                                | [Add-PASAllowedReferrer][Add-PASAllowedReferrer]
[Get allowed referrer][Get allowed referrer]                                                | [Get-PASAllowedReferrer][Get-PASAllowedReferrer]
[Get applications][Get applications]                                                        | [Get-PASApplication][Get-PASApplication]
[Get application details][Get application details]                                          | [Get-PASApplication][Get-PASApplication]
[Add application][Add application]                                                          | [Add-PASApplication][Add-PASApplication]
[Delete application][Delete application]                                                    | [Remove-PASApplication][Remove-PASApplication]
[Get application authentication methods][Get application authentication methods]            | [Get-PASApplicationAuthenticationMethod][Get-PASApplicationAuthenticationMethod]
[Add application authentication method][Add application authentication method]              | [Add-PASApplicationAuthenticationMethod][Add-PASApplicationAuthenticationMethod]
[Delete application authentication method][Delete application authentication method]        | [Remove-PASApplicationAuthenticationMethod][Remove-PASApplicationAuthenticationMethod]
[Add authentication method][Add authentication method]                                      | [Add-PASAuthenticationMethod][Add-PASAuthenticationMethod]
[Update authentication method][Update authentication method]                                | [Set-PASAuthenticationMethod][Set-PASAuthenticationMethod]
[Get specific authentication method][Get specific authentication method]                    | [Get-PASAuthenticationMethod][Get-PASAuthenticationMethod]
[Get authentication methods][Get authentication methods]                                    | [Get-PASAuthenticationMethod][Get-PASAuthenticationMethod]
[PAS System Health Details][PAS System Health Details]                                      | [Get-PASComponentDetail][Get-PASComponentDetail]
[PAS System Health Summary][PAS System Health Summary]                                      | [Get-PASComponentSummary][Get-PASComponentSummary]
[Import connection component][Import connection component]                                  | [Import-PASConnectionComponent][Import-PASConnectionComponent]
[Get all connection components][Get all connection components]                              | [Get-PASConnectionComponent][Get-PASConnectionComponent]
[Import connection component][Import connection component]                                  | [Import-PASConnectionComponent][Import-PASConnectionComponent]
[Get all connection components][Get all connection components]                              | [Get-PASConnectionComponent][Get-PASConnectionComponent]
[Verify credentials][Verify credentials]                                                    | [Invoke-PASCPMOperation][Invoke-PASCPMOperation]
[Change credentials immediately][Change credentials immediately]                            | [Invoke-PASCPMOperation][Invoke-PASCPMOperation]
[Change credentials, set next password][Change credentials, set next password]              | [Invoke-PASCPMOperation][Invoke-PASCPMOperation]
[Change credentials in Vault][Change credentials in Vault]                                  | [Invoke-PASCPMOperation][Invoke-PASCPMOperation]
[Reconcile credentials][Reconcile credentials]                                              | [Invoke-PASCPMOperation][Invoke-PASCPMOperation]
[Get directories][Get directories]                                                          | [Get-PASDirectory][Get-PASDirectory]
[Get directory details][Get directory details]                                              | [Get-PASDirectory][Get-PASDirectory]
[Create directory][Create directory]                                                        | [Add-PASDirectory][Add-PASDirectory]
[Delete directory][Delete directory]                                                        | [Remove-PASDirectory][Remove-PASDirectory]
[Get directory mapping list][Get directory mapping list]                                    | [Get-PASDirectoryMapping][Get-PASDirectoryMapping]
[Get mapping details][Get mapping details]                                                  | [Get-PASDirectoryMapping][Get-PASDirectoryMapping]
[Create directory mapping][Create directory mapping]                                        | [New-PASDirectoryMapping][New-PASDirectoryMapping]
[Edit directory mapping][Edit directory mapping]                                            | [Set-PASDirectoryMapping][Set-PASDirectoryMapping]
[Delete directory mapping][Delete directory mapping]                                        | [Remove-PASDirectoryMapping][Remove-PASDirectoryMapping]
[Reorder directory mappings][Reorder directory mappings]                                    | [Set-PASDirectoryMappingOrder][Set-PASDirectoryMappingOrder]
[Add discovered accounts - Gen 2][Add discovered accounts - Gen 2]                          | [Add-PASDiscoveredAccount][Add-PASDiscoveredAccount]
[Get discovered accounts][Get discovered accounts]                                          | [Get-PASDiscoveredAccount][Get-PASDiscoveredAccount]
[Get discovered account details][Get discovered account details]                            | [Get-PASDiscoveredAccount][Get-PASDiscoveredAccount]
[Get groups][Get groups]                                                                    | [Get-PASGroup][Get-PASGroup]
[Create group][Create group]                                                                | [New-PASGroup][New-PASGroup]
[Delete group][Delete group]                                                                | [Remove-PASGroup][Remove-PASGroup]
[Add member to group][Add member to group]                                                  | [Add-PASGroupMember][Add-PASGroupMember]
[Remove user from group][Remove user from group]                                            | [Remove-PASGroupMember][Remove-PASGroupMember]
[Get Logged On User Details][Get Logged On User Details]                                    | [Get-PASLoggedOnUser][Get-PASLoggedOnUser]
[Get onboarding rules][Get onboarding rules]                                                | [Get-PASOnboardingRule][Get-PASOnboardingRule]
[Add onboarding rule][Add onboarding rule]                                                  | [New-PASOnboardingRule][New-PASOnboardingRule]
[Update onboarding rule][Update onboarding rule]                                            | [Set-PASOnboardingRule][Set-PASOnboardingRule]
[Delete onboarding rule][Delete onboarding rule]                                            | [Remove-PASOnboardingRule][Remove-PASOnboardingRule]
[Add discovered accounts - Gen 1][Add discovered accounts - Gen 1]                          | [Add-PASPendingAccount][Add-PASPendingAccount]
[Get platforms][Get platforms]                                                              | [Get-PASPlatform][Get-PASPlatform]
[Get platform details][Get platform details]                                                | [Get-PASPlatform][Get-PASPlatform]
[Import platform][Import platform]                                                          | [Import-PASPlatform][Import-PASPlatform]
[Export platform][Export platform]                                                          | [Export-PASPlatform][Export-PASPlatform]
[Get target platforms][Get target platforms]                                                | [Get-PASPlatform][Get-PASPlatform]
[Duplicate target platforms][Duplicate target platforms]                                    | [Copy-PASPlatform][Copy-PASPlatform]
[Activate target platform][Activate target platform]                                        | [Enable-PASPlatform][Enable-PASPlatform]
[Deactivate target platform][Deactivate target platform]                                    | [Disable-PASPlatform][Disable-PASPlatform]
[Delete target platform][Delete target platform]                                            | [Remove-PASPlatform][Remove-PASPlatform]
[Get dependent platforms][Get dependent platforms]                                          | [Get-PASPlatform][Get-PASPlatform]
[Duplicate dependent platforms][Duplicate dependent platforms]                              | [Copy-PASPlatform][Copy-PASPlatform]
[Delete dependent platform][Delete dependent platform]                                      | [Remove-PASPlatform][Remove-PASPlatform]
[Get group platforms][Get group platforms]                                                  | [Get-PASPlatform][Get-PASPlatform]
[Duplicate group platforms][Duplicate group platforms]                                      | [Copy-PASPlatform][Copy-PASPlatform]
[Activate group platform][Activate group platform]                                          | [Enable-PASPlatform][Enable-PASPlatform]
[Deactivate group platform][Deactivate group platform]                                      | [Disable-PASPlatform][Disable-PASPlatform]
[Delete group platform][Delete group platform]                                              | [Remove-PASPlatform][Remove-PASPlatform]
[Get rotational group platforms][Get rotational group platforms]                            | [Get-PASPlatform][Get-PASPlatform]
[Duplicate rotational group platforms][Duplicate rotational group platforms]                | [Copy-PASPlatform][Copy-PASPlatform]
[Activate rotational group platform][Activate rotational group platform]                    | [Enable-PASPlatform][Enable-PASPlatform]
[Deactivate rotational group platform][Deactivate rotational group platform]                | [Disable-PASPlatform][Disable-PASPlatform]
[Delete rotational group platform][Delete rotational group platform]                        | [Remove-PASPlatform][Remove-PASPlatform]
[Get session management policy of platform][Get session management policy of platform]      | [Get-PASPlatformPSMConfig][Get-PASPlatformPSMConfig]
[Update session management policy of platform][Update session management policy of platform]| [Set-PASPlatformPSMConfig][Set-PASPlatformPSMConfig]
[Get safes by platform ID][Get safes by platform ID]                                        | [Get-PASPlatformSafe][Get-PASPlatformSafe]
[Get OPM rules][Get OPM rules]                                                              | [Get-PASPolicyACL][Get-PASPolicyACL]
[Add OPM policy][Add OPM policy]                                                            | [Add-PASPolicyACL][Add-PASPolicyACL]
[Delete OPM policy][Delete OPM policy]                                                      | [Remove-PASPolicyACL][Remove-PASPolicyACL]
[Get recordings][Get recordings]                                                            | [Get-PASPSMRecording][Get-PASPSMRecording]
[Get recording details][Get recording details]                                              | [Get-PASPSMRecording][Get-PASPSMRecording]
[Play recording][Play recording]                                                            | [Export-PASPSMRecording][Export-PASPSMRecording]
[Get recording activities][Get recording activities]                                        | [Get-PASPSMRecordingActivity][Get-PASPSMRecordingActivity]
[Get recording properties][Get recording properties]                                        | [Get-PASPSMRecordingProperty][Get-PASPSMRecordingProperty]
[Get all PSM servers][Get all PSM servers]                                                  | [Get-PASPSMServer][Get-PASPSMServer]
[Get active sessions][Get active sessions]                                                  | [Get-PASPSMSession][Get-PASPSMSession]
[Get active session][Get active session]                                                    | [Get-PASPSMSession][Get-PASPSMSession]
[Monitor an active session][Monitor an active session]                                      | [Connect-PASPSMSession][Connect-PASPSMSession]
[Suspend an active session][Suspend an active session]                                      | [Suspend-PASPSMSession][Suspend-PASPSMSession]
[Resume an active session][Resume an active session]                                        | [Resume-PASPSMSession][Resume-PASPSMSession]
[Terminate an active session][Terminate an active session]                                  | [Stop-PASPSMSession][Stop-PASPSMSession]
[Connect using PSM][Connect using PSM]                                                      | [New-PASPSMSession][New-PASPSMSession]
[Ad hoc connect using PSM][Ad hoc connect using PSM]                                        | [New-PASPSMSession][New-PASPSMSession]
[Get active session activities][Get active session activities]                              | [Get-PASPSMSessionActivity][Get-PASPSMSessionActivity]
[Get active session properties][Get active session properties]                              | [Get-PASPSMSessionProperty][Get-PASPSMSessionProperty]
[Get security events][Get security events]                                                  | [Get-PASPTAEvent][Get-PASPTAEvent]
[Update security event][Update security event]                                              | [Set-PASPTAEvent][Set-PASPTAEvent]
[Get security settings - Remediations][Get security settings - Remediations]                | [Get-PASPTARemediation][Get-PASPTARemediation]
[Update security remediation settings][Update security remediation settings]                | [Set-PASPTARemediation][Set-PASPTARemediation]
[Get security settings - Rules][Get security settings - Rules]                              | [Get-PASPTARule][Get-PASPTARule]
[Add risky commands rule][Add risky commands rule]                                          | [Add-PASPTARule][Add-PASPTARule]
[Update risky commands rule][Update risky commands rule]                                    | [Set-PASPTARule][Set-PASPTARule]
[Get public SSH keys][Get public SSH keys]                                                  | [Get-PASPublicSSHKey][Get-PASPublicSSHKey]
[Add a public SSH key][Add a public SSH key]                                                | [Add-PASPublicSSHKey][Add-PASPublicSSHKey]
[Delete Public SSH Key][Delete Public SSH Key]                                              | [Remove-PASPublicSSHKey][Remove-PASPublicSSHKey]
[Get my requests][Get my requests]                                                          | [Get-PASRequest][Get-PASRequest]
[Get incoming request list][Get incoming request list]                                      | [Get-PASRequest][Get-PASRequest]
[Create a request][Create a request]                                                        | [New-PASRequest][New-PASRequest]
[Create access request for multiple accounts][Create access request for multiple accounts]  | [New-PASRequest][New-PASRequest]
[Delete my request][Delete my request]                                                      | [Remove-PASRequest][Remove-PASRequest]
[Get incoming request list][Get incoming request list]                                      | [Get-PASRequest][Get-PASRequest]
[Confirm request][Confirm request]                                                          | [Approve-PASRequest][Approve-PASRequest]
[Reject request][Reject request]                                                            | [Deny-PASRequest][Deny-PASRequest]
[Get details of My Requests][Get details of My Requests]                                    | [Get-PASRequestDetail][Get-PASRequestDetail]
[Get confirmation request details][Get confirmation request details]                        | [Get-PASRequestDetail][Get-PASRequestDetail]
[Get Safes][Get Safes]                                                                      | [Get-PASSafe][Get-PASSafe]
[Search for a Safe][Search for a Safe]                                                      | [Get-PASSafe][Get-PASSafe]
[Get Safe details][Get Safe details]                                                        | [Get-PASSafe][Get-PASSafe]
[Add Safe][Add Safe]                                                                        | [Add-PASSafe][Add-PASSafe]
[Update Safe][Update Safe]                                                                  | [Set-PASSafe][Set-PASSafe]
[Delete Safe][Delete Safe]                                                                  | [Remove-PASSafe][Remove-PASSafe]
[Get members][Get members]                                                                  | [Get-PASSafeMember][Get-PASSafeMember]
[Add member][Add member]                                                                    | [Add-PASSafeMember][Add-PASSafeMember]
[Update member][Update member]                                                              | [Set-PASSafeMember][Set-PASSafeMember]
[Delete member][Delete member]                                                              | [Remove-PASSafeMember][Remove-PASSafeMember]
[Logo][Logo]                                                                                | [Get-PASSafeShareLogo][Get-PASSafeShareLogo]
[Server][Server]                                                                            | [Get-PASServer][Get-PASServer]
[Verify][Verify]                                                                            | [Get-PASServerWebService][Get-PASServerWebService]
[Get Users][Get Users]                                                                      | [Get-PASUser][Get-PASUser]
[Get User Details][Get User Details]                                                        | [Get-PASUser][Get-PASUser]
[Add User][Add User]                                                                        | [New-PASUser][New-PASUser]
[Update User][Update User]                                                                  | [Set-PASUser][Set-PASUser]
[Delete User][Delete User]                                                                  | [Remove-PASUser][Remove-PASUser]
[Activate User][Activate User]                                                              | [Unblock-PASUser][Unblock-PASUser]
[Reset User Password][Reset User Password]                                                  | [Set-PASUserPassword][Set-PASUserPassword]
[Add OpenID Connect Identity Provider][Add OpenID Connect Identity Provider]                | [Add-PASOpenIDConnectProvider][Add-PASOpenIDConnectProvider]
[Get specific OpenID Connect Identity Provider][Get specific OpenID Connect Identity Provider] | [Get-PASOpenIDConnectProvider][Get-PASOpenIDConnectProvider]
[Get all OpenID Connect Identity Providers][Get all OpenID Connect Identity Providers]         | [Get-PASOpenIDConnectProvider][Get-PASOpenIDConnectProvider]
[Delete OpenID Connect Identity Provider][Delete OpenID Connect Identity Provider]             | [Remove-PASOpenIDConnectProvider][Remove-PASOpenIDConnectProvider]
[Update OpenID Connect Identity Provider][Update OpenID Connect Identity Provider]             | [Set-PASOpenIDConnectProvider][Set-PASOpenIDConnectProvider]
[Delete authentication method][Delete authentication method]                                   | [Remove-PASAuthenticationMethod][Remove-PASAuthenticationMethod]
[Delete discovered accounts][Delete discovered accounts]                                       | [Clear-PASDiscoveredAccountList][Clear-PASDiscoveredAccountList]
[Get Secret Versions][Get Secret Versions]                                                     | [Get-PASAccountPasswordVersion][Get-PASAccountPasswordVersion]
[Generate Password][Generate Password]                                                         | [New-PASAccountPassword][New-PASAccountPassword]
[Link an Account][Link an Account]                                                             | [Set-PASLinkedAccount][Set-PASLinkedAccount]
[Unlink an Account][Unlink an Account]                                                         | [Clear-PASLinkedAccount][Clear-PASLinkedAccount]
[Delete all MFA caching SSH keys][Delete all MFA caching SSH keys]                             | [Clear-PASPrivateSSHKey][Clear-PASPrivateSSHKey]
[Generate an MFA caching SSH key][Generate an MFA caching SSH key]                                   | [New-PASPrivateSSHKey][New-PASPrivateSSHKey]
[Generate an MFA caching SSH key for another user][Generate an MFA caching SSH key for another user] | [New-PASPrivateSSHKey][New-PASPrivateSSHKey]
[Delete an MFA caching SSH key][Delete an MFA caching SSH key]                                       | [Remove-PASPrivateSSHKey][Remove-PASPrivateSSHKey]
[Delete an MFA caching SSH key for another user][Delete an MFA caching SSH key for another user]     | [Remove-PASPrivateSSHKey][Remove-PASPrivateSSHKey]
[Update Group][Update Group]                                                                         | [Set-PASGroup][Set-PASGroup]
[Extended Account Overview][Extended Account Overview]                                               | [Get-PASAccountDetail][Get-PASAccountDetail]
[Enable User][Enable User]                                                                           | [Enable-PASUser][Enable-PASUser]
[Disable User][Disable User]                                                                         | [Disable-PASUser][Disable-PASUser]
[Get Global Catalog connectivity details][Get Global Catalog connectivity details]                   | [Get-PASPTAGlobalCatalog][Get-PASPTAGlobalCatalog]
[Add Global Catalog connectivity details][Add Global Catalog connectivity details]                   | [Add-PASPTAGlobalCatalog][Add-PASPTAGlobalCatalog]
[Get user types][Get user types]                                                                     | [Get-PASUserTypeInfo][Get-PASUserTypeInfo]
[Get risk events][Get risk events]                                                                   | [Get-PASPTARiskEvent][Get-PASPTARiskEvent]
[Update risk event][Update risk event]                                                               | [Set-PASPTARiskEvent][Set-PASPTARiskEvent]
[Get risk summary][Get risk summary]                                                                 | [Get-PASPTARiskSummary][Get-PASPTARiskSummary]

[Get-PASUserTypeInfo]:/commands/Get-PASUserTypeInfo
[Get-PASPTARiskEvent]:/commands/Get-PASPTARiskEvent
[Set-PASPTARiskEvent]:/commands/Set-PASPTARiskEvent
[Get-PASPTARiskSummary]:/commands/Get-PASPTARiskSummary
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
[Add-PASOpenIDConnectProvider]:/commands/Add-PASOpenIDConnectProvider
[Get-PASOpenIDConnectProvider]:/commands/Get-PASOpenIDConnectProvider
[Remove-PASOpenIDConnectProvider]:/commands/Remove-PASOpenIDConnectProvider
[Set-PASOpenIDConnectProvider]:/commands/Set-PASOpenIDConnectProvider
[Remove-PASAuthenticationMethod]:/commands/Remove-PASAuthenticationMethod
[Clear-PASDiscoveredAccountList]:/commands/Clear-PASDiscoveredAccountList
[Get-PASAccountPasswordVersion]:/commands/Get-PASAccountPasswordVersion
[New-PASAccountPassword]:/commands/New-PASAccountPassword
[Set-PASLinkedAccount]:/commands/Set-PASLinkedAccount
[Clear-PASLinkedAccount]:/commands/Clear-PASLinkedAccount
[Clear-PASPrivateSSHKey]:/commands/Clear-PASPrivateSSHKey
[New-PASPrivateSSHKey]:/commands/New-PASPrivateSSHKey
[Remove-PASPrivateSSHKey]:/commands/Remove-PASPrivateSSHKey
[Set-PASGroup]:/commands/Set-PASGroup
[Get-PASAccountDetail]:/commands/Get-PASAccountDetail
[Enable-PASUser]:/commands/Enable-PASUser
[Disable-PASUser]:/commands/Disable-PASUser
[Get-PASPTAGlobalCatalog]:/commands/Get-PASPTAGlobalCatalog
[Add-PASPTAGlobalCatalog]:/commands/Add-PASPTAGlobalCatalog

[Get incoming request list]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetIncomingRequestList.htm
[Create access request for multiple accounts]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/13.2/en/Content/WebServices/Create-multiple-requests.htm
[Get risk events]:https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetRiskEvents.htm
[Get risk summary]:https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/GetRisks.htm
[Update risk event]:https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/CloseOpenRiskEvent.htm
[Get user types]:https://docs.cyberark.com/PAS/13.2/en/Content/SDK/API-GetUserTypes.htm
[Get Global Catalog connectivity details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-Global-Catalog.htm
[Add Global Catalog connectivity details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-Global-Catalog.htm
[Enable User]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Enable-user.htm?tocpath=Developer%7CREST%20APIs%7CUser%20management%7CUsers%7C_____8
[Disable User]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Disable-user.htm?tocpath=Developer%7CREST%20APIs%7CUser%20management%7CUsers%7C_____9
[Extended Account Overview]:https://documenter.getpostman.com/view/998920/RzZ9Gz1U#d20c01c2-f7fc-4717-bf10-d8c51cb11411
[Delete discovered accounts]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete-Discovered-accounts.htm
[Get Secret Versions]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Secrets-Get-versions.htm
[Generate Password]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Secrets-Generate-Password.htm
[Link an Account]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Link-account.htm
[Unlink an Account]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Link-account-unlink.htm
[Delete all MFA caching SSH keys]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20all%20MFA%20caching%20SSH%20keys.htm
[Generate an MFA caching SSH key]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Generate%20MFA%20caching%20SSH%20key.htm
[Generate an MFA caching SSH key for another user]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Generate%20MFA%20caching%20SSH%20key%20for%20another%20user.htm
[Delete an MFA caching SSH key]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20MFA%20caching%20SSH%20key.htm
[Delete an MFA caching SSH key for another user]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20MFA%20caching%20SSH%20key%20for%20another%20user.htm
[Update Group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/12.0/en/Content/WebServices/Update-group.htm
[Delete OpenID Connect Identity Provider]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Delete-Provider.htm
[Add OpenID Connect Identity Provider]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Add-Provider.htm
[Update OpenID Connect Identity Provider]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Update-Provider.htm
[Get all OpenID Connect Identity Providers]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Get-All-Providers.htm
[Get specific OpenID Connect Identity Provider]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Get-Specific-Provider.htm
[Delete authentication method]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Authentication-Method-Delete.htm
[CyberArk, LDAP, Radius, Windows Logon]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/CyberArk%20Authentication%20-%20Logon_v10.htm#CyberArkLDAPRadiusWindows
[SAML Logon]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/SAML_%20Authentication_%20Logon_newgen.htm#SAMLlogon
[Shared Logon authentication]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Shared%20Logon%20Authentication%20-%20Logon.htm#Sharedlogonauthentication
[CyberArk, LDAP, Radius, Windows Logoff]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/CyberArk%20Authentication%20-%20Logoff_v10.htm#CyberArkLDAPRadiusWindows
[Shared Logon Authentication Logoff]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Shared%20Logon%20Authentication%20-%20Logoff.htm#Sharedlogonauthenticationlogoff
[Add authentication method]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Add_Authentication_method.htm
[Update authentication method]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Update_Authentication_method.htm
[Get specific authentication method]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Get_specific_Authentication_method.htm
[Get authentication methods]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Get_Authentication_methods.htm
[Verify]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Server%20Web%20Services%20-%20Verify.htm
[Logo]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Server%20Web%20Services%20-%20Logo.htm
[Server]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Server%20Web%20Services%20-%20Server.htm
[PAS System Health Summary]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SystemSummary.htm
[PAS System Health Details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SystemDetails.htm
[Get Users]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/get-users-api.htm
[Get User Details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/get-user-details-v10.htm
[Get Logged On User Details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/User%20Web%20Services%20-%20Logged%20on%20User%20Details.htm
[Add User]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/API-AddUser-v10.htm
[Update User]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Users%20Web%20Services%20-%20Update%20User.htm
[Delete User]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Users%20Web%20Services%20-%20Delete%20User.htm
[Activate User]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/activate-user-v10.htm
[Reset User Password]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/reset-user-password.htm
[Get groups]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetGroupsFromVault.htm
[Create group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/rest-api-create-group.htm
[Delete group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Users%20Web%20Services%20-%20Delete%20User%20Group.htm
[Add member to group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddMemberToGroup%20v10.htm
[Remove user from group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/RemoveUserFromGroup.htm
[Get public SSH keys]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get%20Public%20SSH%20Keys.htm
[Add a public SSH key]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Public%20SSH%20Keys.htm
[Delete Public SSH Key]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Public%20SSH%20Key.htm
[Get directories]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Get_Directories.htm
[Get directory details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Get_directory_details.htm
[Create directory]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Create_Directory.htm
[Delete directory]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteDirectory.htm
[Get directory mapping list]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDirectoryMappingList.htm
[Get mapping details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetMappingDetails.htm
[Create directory mapping]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/LDAP_Create_Directory_Mapping.htm
[Edit directory mapping]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/EditDirectoryMapping.htm
[Delete directory mapping]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete-directory-mapping.htm
[Reorder directory mappings]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-reorder-map.htm
[Get Safes]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Safes%20Web%20Services%20-%20List%20Safes.htm
[Search for a Safe]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Safes%20Web%20Services%20-%20Search%20for%20Safe.htm
[Get Safe details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Safes%20Web%20Services%20-%20Get%20Safes%20Details.htm
[Get Safe account groups]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetSafeAccountGroups.htm
[Add Safe]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Safe.htm
[Update Safe]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Update%20Safe.htm
[Delete Safe]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Safe.htm
[Get safes by platform ID]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-safe-by-platform.htm
[Get members]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Safe%20Members%20WS%20-%20List%20Safe%20Members.htm
[Add member]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Safe%20Member.htm
[Update member]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Update%20Safe%20Member.htm
[Delete member]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Safe%20Member.htm
[Import connection component]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ImportConnComponent.htm
[Get all connection components]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Get_All_Connection_Components.htm
[Get all PSM servers]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Get_All_PSM_Servers.htm
[Get session management policy of platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Get_Session_Management_Policy_Platform.htm
[Update session management policy of platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Update_Session_Management_Policy_Platform.htm
[Get platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-platforms.htm
[Get platform details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetPlatformDetails.htm
[Import platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ImportPlatform.htm
[Export platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/ExportPlatform.htm
[Get target platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-target-platforms.htm
[Duplicate target platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-target-platforms.htm
[Activate target platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-target-platform.htm
[Deactivate target platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-deactivate-target-platform.htm
[Delete target platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-target-platform.htm
[Get dependent platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-dependent-platforms.htm
[Duplicate dependent platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-dependent-platforms.htm
[Delete dependent platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-dependent-platform.htm
[Get group platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-group-platforms.htm
[Duplicate group platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-group-platforms.htm
[Activate group platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-group-platform.htm
[Deactivate group platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-deactivate-group-platform.htm
[Delete group platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-goup-platform.htm
[Get rotational group platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-rotational-group-platforms.htm
[Duplicate rotational group platforms]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-rotational-group-platforms.htm
[Activate rotational group platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-rotational-group-platform.htm
[Deactivate rotational group platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-deactivate-rotational-group-platform.htm
[Delete rotational group platform]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-rotational-group-platform.htm
[Get accounts]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/GetAccounts.htm
[Get account details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get%20Account%20Details.htm
[Get account activity]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Files%20-%20Get%20File%20Activity%20by%20ID.htm
[Add account]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Account%20v10.htm
[Add discovered accounts - Gen 2]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Discovered%20Account%20v10.8.htm
[Update account]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/UpdateAccount%20v10.htm
[Delete account]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Account.htm
[Get my requests]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetMyRequests.htm
[Get details of My Requests]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDetailsMyRequest.htm
[Create a request]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/CreateRequest.htm
[Delete my request]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteMyRequest.htm
[Get incoming request list]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetIncomingRequestList.htm
[Get confirmation request details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetDetailsRequestConfirmation.htm
[Confirm request]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ConfirmRequest.htm
[Reject request]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/RejectRequest.htm
[Get onboarding rules]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAutoOnboardingRules.htm
[Add onboarding rule]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddAutomaticOnboardingRule.htm
[Update onboarding rule]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/EditAutomaticOnboardingRule.htm
[Delete onboarding rule]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteAutoOnboardingRule.htm
[Get active sessions]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetLiveSessions.htm
[Get active session]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetActiveSession.htm
[Get active session activities]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetActiveSessionProperties.htm
[Get active session properties]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetActiveSessionProperties.htm
[Monitor an active session]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PSM%20-%20Monitor%20Sessions.htm
[Suspend an active session]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Suspend-ResumeSession.htm
[Resume an active session]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Suspend-ResumeSession.htm
[Terminate an active session]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PTA-PSM-TerminateSession.htm
[Get recordings]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordings.htm
[Get recording details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecording.htm
[Get recording properties]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordingProperties.htm
[Get recording activities]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordingActivities.htm
[Play recording]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PlayRecording.htm
[Get security events]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetSecurityEvents.htm
[Update security event]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/CloseOpenSecurityEvent.htm
[Get security settings - Remediations]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetSettings.htm
[Get security settings - Rules]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetSettings.htm
[Update security remediation settings]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AutomaticRemediation_UpdateConfiguration.htm
[Add risky commands rule]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AddNewRule.htm
[Update risky commands rule]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/UpdateRule.htm
[Get applications]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Applications.htm
[Get application details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20a%20Specific%20Application.htm
[Get application authentication methods]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20all%20Authentication%20Methods%20of%20a%20Specific%20Application.htm
[Add application]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Application.htm
[Add application authentication method]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Authentication.htm
[Delete application]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20a%20Specific%20Application.htm
[Delete application authentication method]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20a%20Specific%20Authentication.htm
[Get OPM rules]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Policy%20ACL.htm
[Add OPM policy]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Policy%20ACL.htm
[Delete OPM policy]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Policy%20ACL.htm
[Get OPM account commands]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/List%20Account%20ACL.htm
[Add OPM account commands]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Account%20ACL.htm
[Delete OPM account commands]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Account%20ACL.htm
[Add allowed referrer]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Add_Allowed_Referrer.htm
[Get allowed referrer]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Get_Allowed_Referrer.htm
[Get account group by Safe]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccountGroupBySafe.htm
[Get account group members]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccountGroupMembers.htm
[Add account group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-account-group.htm
[Add member to account group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add-account-to-account-group.htm
[Delete member from account group]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/DeleteMemberFromAccountGroup.htm
[Get Just in Time access]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccess.htm
[Revoke Just in Time access]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Revoke-access.htm
[Connect using PSM]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ConnectThroughPSM.htm
[Ad hoc connect using PSM]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SecureConnectPSM.htm
[Get password value]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetPasswordValueV10.htm
[Retrieve private SSH key account]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Retrieve_Private_SSH_Key_Account.htm
[Check in an exclusive account]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Checkin-account.htm
[Verify credentials]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Verify-credentials-v9-10.htm
[Change credentials immediately]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Change-credentials-immediately.htm
[Change credentials, set next password]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SetNextPassword.htm
[Change credentials in Vault]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ChangeCredentialsInVault.htm
[Reconcile credentials]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Reconcile-account.htm
[Add discovered accounts - Gen 1]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Discovered%20Account%20v10.8.htm
[Get discovered accounts]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-discovered-accounts.htm
[Get discovered account details]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-discovered-account-details.htm
[Create bulk upload of accounts]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Create-bulk-upload-of-accounts-v10.htm
[Get all bulk account uploads for user]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-all-bulk-account-uploads-for-user-v10.htm
[Get bulk account upload result]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get-bulk-account-upload-result-v10.htm
[Import connection component]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ImportConnComponent.htm
[Get all connection components]:https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Get_All_Connection_Components.htm
