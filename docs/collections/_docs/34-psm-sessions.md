---
title: "PSM Sessions"
permalink: /docs/psm-sessions/
excerpt: "psPAS PSM Sessions"
last_modified_at: 2019-09-01T01:33:52-00:00
---

## Terminate all Active PSM Sessions on a PSM Server

````powershell
#Find Active Sessions for a PSM Server IP
#Terminate the Sessions
Get-PASPSMSession | Where-Object{
  ($_.RawProperties.ProviderID -eq $(Get-PASComponentDetail -ComponentID SessionManagement |
    Where-Object{$_.ComponentIP -eq "192.168.60.20"} |
    Select -ExpandProperty ComponentUserName))
  -and ($_.IsLive) -and ($_.CanTerminate)} | Stop-PASPSMSession
````
