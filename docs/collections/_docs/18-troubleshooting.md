---
title: "Troubleshooting"
permalink: /docs/troubleshooting/
excerpt: "Troubleshooting"
last_modified_at: 2021-07-07zT01:23:45-00:00
toc: true
---

psPAS covers the capabilities of the API published by the Vendor. The published API documentation is the basis for all module operations.

Links to official vendor documentation each psPAS command is developed against can be found in the Related Links section of the output of `Get-Help -Full <CommandName>`, or via the [command help](https://pspas.pspete.dev/commands/) pages.

To understand any issue you may be experiencing, familiarisation with both the module documentation and the underlying API requirements & parameters is encouraged.

A lot of issues reported to the project stem from sources outside of the psPAS codebase, such as, incorrect parameter values or usage, environment or security configuration, web service configuration, or compatibility or versions relating to only specific PAS version levels.

Use the resources on this page to help navigate the project and information in the public domain to find resolutions for any challenge with psPAS you may face.

## Previous Issues

Check the historic [issues](https://github.com/pspete/psPAS/issues?q=is%3Aissue) logged for the module; it is possible an answer, reason or resolution has already been provided for any observed behaviour.

## Error Messages

HTTP Status codes and/or CyberArk error codes are included in any error output by the module.

Application codes can be researched via [docs.cyberark.com](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/MESSAGES/Application.htm?tocpath=Administration%7CReferences%7CMessages%20and%20Responses%7CDigital%20Vault%20Server%7C_____1) or the [CyberArk Community](https://cyberark-customers.force.com/s/).

For HTTP status codes which do not indicate success, IIS & PVWA logs should be examined for more in depth analysis for potential reasons a behaviour is being observed.

For errors reported to the project which involve a status code of 500 (Server Error), see the [troubleshooting steps](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Implementing%20Privileged%20Account%20Security%20Web%20Services%20.htm?tocpath=Developer%7CREST%20APIs%7C_____0) suggested in the vendor documentation relating to HTTPS bindings.

## Version Compatibility

Details of features specific to certain PAS version can be found in the [compatibility](https://pspas.pspete.dev/docs/compatibility/) documentation. Version requirements are also recorded in the [parameter help](https://pspas.pspete.dev/commands/) content for each command.

The module performs a version check for the currently in use PAS web service in order to alert and prevent usage of commands or parameters which are not supported. As psPAS is backward compatible against older CyberArk versions, this is in an effort to save confusion and lower the volume of issues raised relating to module behaviour when a command uses a newer API endpoint or request format not supported by the version in use and results in an error.

To suppress any checks for compatible PAS version when using the module, the `-SkipVersionCheck` parameter of `New-PASSession` can be specified during authentication.
{: .notice--info}

### Module Versions

New versions of psPAS may contain breaking changes; the way something works in a previous psPAS version may be updated on changed in newer versions. i.e. newer versions will generally default to using Gen2 API requests and endpoints, superseding Gen1 commands as and when new API endpoints are features are released in each new PAS version.
{: .notice--warning}

To ensure stability in any developed scripts, consider specifying `Import-Module -RequiredVersion X.Y.Z` when importing the module, or including `#Requires -Modules @{ ModuleName="psPAS"; ModuleVersion="X.Y.Z" }` (see [about_requires](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_requires)) as a statement in the script file (where `X.Y.Z` relates to the psPAS module version used during script development). This will prevent module changes affecting script operation when newer psPAS versions are released and installed and allow any required refactoring to take place.

#### CHANGELOG

The [CHANGELOG](https://github.com/pspete/psPAS/blob/master/CHANGELOG.md) of the module contains details of all module updates and any notes relating behaviour changes.

Review the release notes for the module to see if any issue being observed is related to documented changes to the operation of the module.
{: .notice--info}

## Manual API Command Testing

You can confirm if an issue only occurs when using command from the module, or whether it is also exhibited when issuing a command to the API using native PowerShell.
{: .notice--success}

This is achieved by using psPAS to first authenticate to the API and using the `Get-PASSession` command to obtain the same `WebSession` psPAS would use to for its subsequent API operations.

Using the documentation to define and format the details required, and including the `WebSession` enables the request to be sent to the API and for the operation to be tested outside of module.

For example, to send the same request as [Get-PASPlatform](https://pspas.pspete.dev/commands/Get-PASPlatform), the [Get Platforms](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-platforms.htm?TocPath=Developer%7CREST%20APIs%7CPlatforms%7C_____1) API documentation can be used to form request details as follows:

```powershell
#after New-PASSession
$ThisSession = Get-PASSession

$Method = "GET"
$UrlPath = "API/Platforms"

$Request = @{
    "Method"      = $Method
    "Uri"         = "$($ThisSession.BaseUri)/$UrlPath"
    "WebSession"  = $ThisSession.WebSession
    "ContentType" = "application/json"
}

Invoke-RestMethod @Request
```

If an issue is observed both when using a module command and also when testing outside of the module, this usually indicates that there is nothing to fix in the module itself (i.e. there is no fix which can be provided to the code or logic of the module).

If an issue is only observed when using the module, and tests outside the module are successful, [open an issue](#logging-an-issue) for investigation.
{: .notice--info}

## Logging an Issue
[Open a new issue](https://github.com/pspete/psPAS/issues/new?assignees=&labels=&template=issue-report.md&title=) to engage with the project on issues being faced with the usage of the psPAS tool itself.

Ensure all detail requested in the issue template is provided (anonymise as required).
{: .notice--warning}

Providing the requested information helps us help you quicker; providing some basic information upfront saves time by allowing all variables which could affect module operation or functionality to be immediately understood.

Not completing the template will delay both in response and resolution.

Please use your standard support channels for issues which do not relate to operation of the module.

## Fixing Issues & Contributing to the Project

If you have identified a fix for issue or potential improvement for psPAS and want to submit your update for inclusion in the project, this is great news, both welcome & encouraged!

See the [contributing guide](https://github.com/pspete/psPAS/blob/master/CONTRIBUTING.md) for all details about how to submit Pull Requests to the project for any updates to code or documentation.
