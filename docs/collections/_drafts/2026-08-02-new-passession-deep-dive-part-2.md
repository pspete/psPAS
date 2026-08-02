---
title:  "New-PASSession Deep Dive - Part 2: ISPSS & IdentityCommand"
date:   2026-08-02 00:00:00
tags:
  - psPAS Article
  - Deep Dive
  - New-PASSession
  - IdentityCommand
  - New-IDSession
  - New-IDPlatformToken
  - Find-SharedServicesURL
  - ISPSS
  - Privilege Cloud
  - SAML
---

Back in [New-PASSession Deep Dive]({{ site.url }}{{ site.baseurl }}/articles/new-passession-deep-dive/) we walked through how **`New-PASSession`** authenticates against a self-hosted CyberArk Privileged Access Manager installation - RADIUS challenges, IIS/Vault combined authentication, and SAML via `Get-PASSAMLResponse`.

Since that article was written, CyberArk's SaaS offering - the Identity Security Platform Shared Services, or **ISPSS** - has become the way most new customers consume Privilege Cloud. Authenticating against it doesn't look anything like authenticating against a self-hosted Vault: instead of a single logon call to the PVWA, a request has to be authenticated against **CyberArk Identity** first, and only then handed a Privilege Cloud API URL to work against.

Rather than re-implementing an entire identity platform's authentication surface inside psPAS, **`New-PASSession`** delegates this part of the job to a companion module, **IdentityCommand**. This article is the "part 2" - what's changed, what's new, and how **`New-PASSession`** and **IdentityCommand** work together to get you a Privilege Cloud session.

## What's New Since Part 1

Everything covered in the original article still applies unchanged for self-hosted (Gen1/Gen2) authentication. On top of that, **`New-PASSession`** has gained a family of `ISPSS-*` parameter sets:

- `ISPSS-Subdomain-IdentityUser` / `ISPSS-URL-IdentityUser` - interactive authentication with a `-Credential`, including any MFA challenges configured for the user.
- `ISPSS-Subdomain-ServiceUser` / `ISPSS-URL-ServiceUser` - non-interactive authentication for a CyberArk Identity **Service User** (an OAuth2 client id/secret pair, provided as a `-Credential`), intended for unattended automation.
- `ISPSS-Subdomain-SAML` / `ISPSS-URL-SAML` - authentication using a SAML assertion obtained from a federated identity provider, the newest addition to this family.

The `-Subdomain`/`-URL` split running through all three pairs reflects two different ways of telling **`New-PASSession`** where your tenant lives, covered below in [Tenant Discovery](#tenant-discovery).

## A New Dependency: IdentityCommand

**`New-PASSession`** doesn't implement CyberArk Identity's authentication protocol itself. Instead, any `ISPSS-*` parameter set delegates the actual logon to **IdentityCommand**, a separate PowerShell module dedicated to CyberArk Identity operations, calling either `New-IDSession` (IdentityUser/SAML) or `New-IDPlatformToken` (ServiceUser).

That split isn't just tidiness for its own sake. CyberArk Identity's authentication mechanics - multi-step challenge/response, OOB polling, IdP redirects - are a big, fast-moving area in their own right, and they version and change independently of the Privilege Cloud/PAS API surface that the rest of psPAS wraps. Keeping that logic in its own module means it can be maintained and released on its own schedule, instead of every psPAS release having to keep pace with it.

Because of this, IdentityCommand is only ever needed if you actually use one of the `ISPSS-*` parameter sets - self-hosted users never need to install it. **`New-PASSession`** checks for it lazily, right before it's needed:

```powershell
if (-not (Get-Module IdentityCommand)) {
	try { Import-Module IdentityCommand -ErrorAction Stop }
	catch { throw 'Failed to import IdentityCommand: Install the IdentityCommand Module and try again.' }
}
```

Miss that step and, rather than a baffling "command not found" for `New-IDSession`, you're told plainly what's missing and how to fix it.

## Tenant Discovery

Before any authentication can happen, **`New-PASSession`** needs two URLs: one for CyberArk Identity (`IdentityTenantURL`) and one for the Privilege Cloud API (`PrivilegeCloudURL`). There are two ways to supply them:

- Provide both explicitly with `-IdentityTenantURL` and `-PrivilegeCloudURL` (the `ISPSS-URL-*` parameter sets).
- Provide just `-TenantSubdomain` (the `ISPSS-Subdomain-*` parameter sets) and let **`New-PASSession`** resolve both URLs for you.

The subdomain path is handled by the private `Find-SharedServicesURL` helper, which queries CyberArk's public platform discovery service and returns the full set of shared-service URLs registered for that subdomain - Identity, Privilege Cloud, and several others (`audit`, `sca`, `secrets_hub`, and so on) that other parts of the platform use but psPAS doesn't:

```powershell
Find-SharedServicesURL -subdomain somedomain -service pcloud
```

```plantuml
@startuml
title New-PASSession (ISPSS)

participant "New-PASSession" as NPS
participant "Find-SharedServicesURL" as Discover
participant "platform-discovery.cyberark.cloud" as Discovery
participant "IdentityCommand" as ID

note over NPS: TenantSubdomain\n-or-\nIdentityTenantURL / PrivilegeCloudURL

opt TenantSubdomain supplied
	NPS -> Discover: subdomain
	Discover -> Discovery: GET /services/subdomain/{subdomain}
	Discovery --> Discover: Service URLs
	Discover --> NPS: IdentityTenantURL, PrivilegeCloudURL
end

note over NPS: Import IdentityCommand\n(if not already loaded)

note over NPS: IdentityUser / ServiceUser / SAML

NPS -> ID: New-IDSession / New-IDPlatformToken
ID --> NPS: Token / access_token, WebSession

note over NPS: BaseURI = PrivilegeCloudURL/PVWAAppName\nApiURI = PrivilegeCloudURL
@enduml
```

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession-Part2/Overview.png){: .half .align-center}

Whichever route is used, once both URLs are known the flow converges - the `IdentityTenantURL` is handed to IdentityCommand to authenticate against, and the `PrivilegeCloudURL` becomes the base for every subsequent psPAS command in the session.

## Identity User Authentication

`-IdentityUser` is the interactive case: a human, a `-Credential`, and potentially an MFA challenge to satisfy - the CyberArk Identity equivalent of typing your password and then approving a push notification.

**`New-PASSession`** hands off to `New-IDSession -Credential`, which drives CyberArk Identity's multi-step authentication API:

- `Start-Authentication` posts the username to `/Security/StartAuthentication`. The response may redirect to a different pod (`PodFqdn`) for the actual tenant, in which case the request is retried against the new host, or it may return a list of challenge mechanisms the user must satisfy.
- For each challenge, `Select-ChallengeMechanism` and `Get-MechanismAnswer` work out what's being asked (password, OATH OTP, email/SMS code, push notification, security question, ...) and obtain an answer, before `Start-AdvanceAuthentication` posts it to `/Security/AdvanceAuthentication`.
- Out-of-band mechanisms (push, email, SMS) return an `OobPending` status that's polled every couple of seconds until the user responds, rather than requiring an immediate answer.
- Once every challenge in the set has been satisfied, a bearer `Token` is returned.

```plantuml
@startuml
title Identity User Authentication

participant "New-PASSession" as NPS
participant "New-IDSession" as NewID
participant "Start-Authentication" as Start
participant "CyberArk Identity" as Identity
participant "Start-AdvanceAuthentication" as Advance

NPS -> NewID: Credential
NewID -> Start: Credential
Start -> Identity: POST /Security/StartAuthentication

opt PodFqdn redirect returned
	Identity --> Start: PodFqdn
	Start -> Identity: POST /Security/StartAuthentication (new pod)
end

Identity --> Start: Challenges
Start --> NewID: Challenges

loop each challenge mechanism
	NewID -> NewID: Select-ChallengeMechanism
	NewID -> NewID: Get-MechanismAnswer
	NewID -> Advance: Mechanism, Answer
	Advance -> Identity: POST /Security/AdvanceAuthentication
	note over Advance: Poll every 2s if\nOobPending (push/email/SMS)
	Identity --> Advance: Next Challenge / Token
	Advance --> NewID: Result
end

NewID --> NPS: Token, WebSession
@enduml
```

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession-Part2/IdentityUser.png){: .half .align-center}

This is the closest ISPSS equivalent of Part 1's RADIUS challenge/response flow - a loop of challenge and answer - except here the entire loop happens inside IdentityCommand, and **`New-PASSession`** only ever sees the final `Token`.

## Service User Authentication

`-ServiceUser` is the non-interactive case, intended for scheduled tasks, pipelines, and other unattended automation where there's no human available to answer an MFA challenge. A CyberArk Identity **Service User** is configured with an OAuth2 client id and secret, supplied to **`New-PASSession`** as a `-Credential` in the same way any other credential is.

**`New-PASSession`** hands off to `New-IDPlatformToken`, which performs a standard OAuth2 client-credentials grant against `/OAuth2/PlatformToken`:

```powershell
$LogonRequest['Body'] = @{
	grant_type    = 'client_credentials'
	client_id     = $($Credential.UserName)
	client_secret = $($Credential.GetNetworkCredential().Password)
}
```

```plantuml
@startuml
title Service User Authentication

participant "New-PASSession" as NPS
participant "New-IDPlatformToken" as Token
participant "CyberArk Identity" as Identity

NPS -> Token: Credential (client_id / client_secret)
Token -> Identity: POST /OAuth2/PlatformToken\ngrant_type=client_credentials
Identity --> Token: access_token, token_type
Token --> NPS: access_token, WebSession
@enduml
```

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession-Part2/ServiceUser.png){: .half .align-center}

There's no challenge loop here at all - just a single request/response exchange, which is why it's the one to reach for anywhere unattended.

## SAML Authentication via Identity

The newest addition to the ISPSS family lets a SAML assertion obtained from a federated identity provider be exchanged for a Privilege Cloud session, using the same `-SAMLResponse` parameter already familiar from Part 1's Gen1/Gen2 SAML parameter sets - only this time it's presented to CyberArk Identity rather than directly to a self-hosted PVWA.

`New-IDSession -SAMLResponse` drives this in two steps:

- `Start-SamlAuthentication` posts the assertion to the tenant's `/my` endpoint. A successful response sets a handful of authentication cookies (`.ASPXAUTH`, `antixss`, `CCSID`, `podloc`, `sessdata`, `userdata`) into the request's `WebSession`.
- `Complete-SamlAuthentication` then issues a `GET` against `/login` using that same `WebSession`, so the cookies just obtained are presented back to the tenant, which responds with the bearer `Token`.

```plantuml
@startuml
title SAML Authentication (Identity)

participant "New-PASSession" as NPS
participant "New-IDSession" as NewID
participant "Start-SamlAuthentication" as Start
participant "Complete-SamlAuthentication" as Complete
participant "CyberArk Identity" as Identity

NPS -> NewID: SAMLResponse
NewID -> Start: SAMLResponse
Start -> Identity: POST /my\nSAMLResponse
Identity --> Start: Authentication Cookies
Start --> NewID: WebSession

NewID -> Complete: WebSession (Cookies)
Complete -> Identity: GET /login
Identity --> Complete: Token
Complete --> NewID: Token

NewID --> NPS: Token, WebSession
@enduml
```

![alt]({{ site.url }}{{ site.baseurl }}/assets/images/New-PASSession-Part2/SAML.png){: .half .align-center}

As with self-hosted SAML, obtaining the `SAMLResponse` value from your IdP in the first place is outside psPAS's scope - see Part 1's notes on [PS-SAML-Interactive](https://github.com/allynl93/PS-SAML-Interactive) for one community-provided way to get one interactively.

## Feeding the Result Back into psPASSession

However you get there, IdentityCommand hands **`New-PASSession`** back an object shaped differently depending on the auth method - a `Token` property for IdentityUser/SAML, or an `access_token`/`token_type` pair for ServiceUser - alongside a `GetWebSession()` script method that IdentityCommand attaches to let **`New-PASSession`** retrieve the `WebSession` it built up during authentication (cookies and all, in the SAML case).

**`New-PASSession`**'s existing result-handling `switch`, already responsible for recognising a classic `CyberArkLogonResult` or Gen2 `LogonResult` from self-hosted logons, gained two more branches to recognise these shapes and normalise them into the same thing every other psPAS command expects - a single `Authorization` header value on `$psPASSession.WebSession`:

```powershell
( { $null -ne $PSItem.access_token } ) {
	#Shared Service access_token.
	$CyberArkLogonResult = "$($PASSession.token_type) $($PASSession.access_token)"
	$psPASSession.WebSession = $($PSItem.GetWebSession())
}

( { $null -ne $PSItem.Token } ) {
	#Shared Services Identity User Bearer Token
	$CyberArkLogonResult = "Bearer $($PASSession.Token)"
	$psPASSession.WebSession = $($PSItem.GetWebSession())
}
```

Two more values are set that don't apply to self-hosted sessions:

- `$psPASSession.BaseURI` is set to the Privilege Cloud PVWA URL (`PrivilegeCloudURL/PVWAAppName`), exactly as `BaseURI` is for a self-hosted session - every other psPAS command keeps working against it unmodified.
- `$psPASSession.ApiURI` is set to the raw `PrivilegeCloudURL`, without the rest of the module needing to know how the session was authenticated. It's how helpers like `Get-NextLink` and version-aware commands can tell a Privilege Cloud session apart from a self-hosted one, since the two don't always shape pagination and version-gated responses the same way.

From here on, the session behaves exactly as described in Part 1 and in [Anatomy of a psPAS Command]({{ site.url }}{{ site.baseurl }}/articles/anatomy-of-a-pspas-command/) - every other command reads `$psPASSession.WebSession` and `$psPASSession.BaseURI` without caring whether `New-PASSession` got there via a Vault logon or via IdentityCommand.

## Summary

Authenticating to ISPSS/Privilege Cloud looks nothing like authenticating to a self-hosted Vault under the hood, but **`New-PASSession`** soaks up that difference for you: three ISPSS parameter sets, a lazily-loaded dependency on IdentityCommand, and a bit of result normalisation at the end, and the rest of psPAS never has to know which kind of session it's talking to.

Did we forget anything?

Let us know if there is any further information you would want to see or if you have any questions that have not been answered.
