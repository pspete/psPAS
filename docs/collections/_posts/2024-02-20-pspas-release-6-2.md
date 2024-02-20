---
title: "psPAS Release 6.2"
date: 2024-02-20 00:00:00
tags:
  - Release Notes
  - Invoke-PASRestMethod
  - Get-PASSession
  - Add-PASGroupMember
  - Remove-PASGroup
  - Set-PASGroup
  - New-PASPSMSession
  - New-PASSession
---

## **6.2.68**

Introducing enhancements to psPAS session related data.

Using the `Get-PASSession` command, users of the module can now get data on session start time, elapsed time since authentication as well as details of the last command run, the raw results returned from the api, as well as any detail of the last error which may have been received during the session.

This update makes troubleshooting API commands and expected results much easier from both an end user and module support perspective.

```powershell
PS> Get-PASSession

Name                           Value
----                           -----
BaseURI                        https://sometenant.privilegecloud.cyberark.cloud/PasswordVault
User                           someuser@cyberark.cloud.1312
ExternalVersion                14.0.0
WebSession                     Microsoft.PowerShell.Commands.WebRequestSession
StartTime                      20/02/2024 18:14:01
ElapsedTime                    00:04:03
LastCommand                    System.Management.Automation.InvocationInfo
LastCommandTime                20/02/2024 18:18:03
LastCommandResults             {"Users":[{"id":26,"username":"someuser@somedomain.com","source":"CyberArk","userType":"SomeType",...
LastError                      {"ErrorCode":"PASWS041E","ErrorMessage":"You are not authorized to perform this action."}
LastErrorTime                  20/02/2024 18:13:12
```

To realise this update, lots of module wide changes to all module commands have been required; while no change to the general operation of the psPAS module should be noticed - do raise an issue if something does not appear correct.

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
