---
title: "API Sessions"
permalink: /docs/api-sessions/
excerpt: "psPAS API Sessions"
last_modified_at: 2026-08-01T01:33:52-00:00
---

- If actions are required to be performed under the context of different user accounts, it is possible to work with different authenticated sessions:

```powershell
#Start first session
$VaultAdmin = Get-Credential

PowerShell credential request
Enter your credentials.
User: VaultAdmin
Password for user VaultAdmin: **********


New-PASSession -Credential $VaultAdmin -BaseURI https://pvwa.somedomain.com

Get-PASLoggedOnUser

UserName   Source   UserTypeName AgentUser Expired Disabled Suspended
--------   ------   ------------ --------- ------- -------- ---------
VaultAdmin Internal EPVUser      False     False   False    False

#Save first session data
$FirstSession = Get-PASSession

#Start second session
$SafeAdmin = Get-Credential

PowerShell credential request
Enter your credentials.
User: SafeAdmin
Password for user SafeAdmin: **********


New-PASSession -Credential $SafeAdmin -BaseURI https://pvwa.somedomain.com

Get-PASLoggedOnUser

UserName  Source   UserTypeName AgentUser Expired Disabled Suspended
--------  ------   ------------ --------- ------- -------- ---------
SafeAdmin Internal EPVUser      False     False   False    False

#Save second session data
$SecondSession = Get-PASSession

#Switch back to first session
Use-PASSession -Session $FirstSession

Get-PASLoggedOnUser

UserName   Source   UserTypeName AgentUser Expired Disabled Suspended
--------   ------   ------------ --------- ------- -------- ---------
VaultAdmin Internal EPVUser      False     False   False    False

#End first session
Close-PASSession

#Switch to second session
Use-PASSession -Session $SecondSession

Get-PASLoggedOnUser

UserName  Source   UserTypeName AgentUser Expired Disabled Suspended
--------  ------   ------------ --------- ------- -------- ---------
SafeAdmin Internal EPVUser      False     False   False    False

#End second session
Close-PASSession
```

## Tracking session idle-timeout

`Get-PASSession` includes an estimate of how much longer the current session has before it idle-times out on the server, calculated from the idle timeout value retrieved at logon and the time of the most recent request:

```powershell
(Get-PASSession).SessionTimeRemaining
```

If a request is sent while the session has 5 minutes (configurable via `SessionWarningThreshold`) or less remaining, `psPAS` writes a warning that the session is close to idle-timing out.

The session object also exposes two methods for working with this data - see [Methods](/docs/methods/) for details:

- `(Get-PASSession).GetRemainingSessionTime()` - returns a live, freshly-calculated time remaining.
- `(Get-PASSession).Refresh()` - resets the idle timer for the current session, extending it.
