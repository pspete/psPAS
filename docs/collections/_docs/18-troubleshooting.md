---
title: "Troubleshooting"
permalink: /docs/troubleshooting/
excerpt: "Troubleshooting"
last_modified_at: 2022-09-23T01:23:45-00:00
toc: true
---

psPAS covers the capabilities of the API published by the Vendor. The [published API documentation](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Implementing%20Privileged%20Account%20Security%20Web%20Services%20.htm?tocpath=Developer%7CREST%20APIs%7C_____0) is the basis for all module operations.

The Related Links section of the `Get-Help -Full CommandName>` output, or the [command help](https://pspas.pspete.dev/commands/) pages include links to the official vendor documentation that each psPAS command is based on.

It is recommended that you become familiar with both the module documentation and the underlying API requirements and parameters in order to better understand any problem you may be having using psPAS.

Many of the issues reported to the project are caused by things beyond the psPAS codebase, like incorrect parameter values or usage, incorrect environment or security configuration, incorrect web service configuration, or compatibility considerations which apply to certain PAS version levels.

Use the tools on this website to explore the project and other freely accessible content to discover answers to any problems you may run into using psPAS.

The information on this page always refers to the most recent module release. If you are using a previous version of the module, use the PowerShell Get-Help CmdLet to view the module help for information specific to your module version.
{: .notice--info}

## Previous Issues

Check the historic [issues](https://github.com/pspete/psPAS/issues?q=is%3Aissue) logged for the module; it is possible an answer, reason or resolution has already been provided for any observed behaviour.

## Error Messages

HTTP Status codes and/or CyberArk error codes are included in any error output by the module.

Application codes can be researched via [docs.cyberark.com](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/MESSAGES/Application.htm?tocpath=Administration%7CReferences%7CMessages%20and%20Responses%7CDigital%20Vault%20Server%7C_____1) or the [CyberArk Community](https://cyberark-customers.force.com/s/).

IIS & PVWA logs should be checked for a more thorough analysis of any probable causes for any HTTP status codes that do not indicate success.

For errors reported to the project which involve a status code of 500 (Server Error), see the [troubleshooting steps](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Implementing%20Privileged%20Account%20Security%20Web%20Services%20.htm?tocpath=Developer%7CREST%20APIs%7C_____0) suggested in the vendor documentation relating to HTTPS bindings.

## Version Compatibility

The [compatibility](https://pspas.pspete.dev/docs/compatibility/) documentation contains information on features specific to particular PAS versions. Version requirements are also listed in each command's [parameter help](https://pspas.pspete.dev/commands/) text.

In in order to alert users and restrict the execution of commands or arguments that are not supported, the module runs a version check on the PAS web service that is currently in use.

In an attempt to minimize confusion and reduce the number of questions about module behaviour, when a command employs a newer API endpoint or request format which is incompatible with the target CyberArk PAS version, an error is generated.

psPAS remains backward compatible against older CyberArk versions.

To suppress any checks for compatible PAS version when using the module, the `-SkipVersionCheck` parameter of `New-PASSession` can be specified during authentication.
{: .notice--info}

### Module Versions

Breaking changes may be included in newer versions of psPAS, which could change how some features work compared to older psPAS versions. As new API endpoints and functionality are made available in each CyberArk PAS version release, newer psPAS versions will typically supersede older Gen1 API commands and default to newer Gen2 API requests and endpoints instead.
{: .notice--warning}

To ensure stability in any developed scripts, consider specifying `Import-Module -RequiredVersion X.Y.Z` when importing the module, or including `#Requires -Modules @{ ModuleName="psPAS"; ModuleVersion="X.Y.Z" }` (see [about_requires](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_requires)) as a statement in the script file (where `X.Y.Z` relates to the psPAS module version used during script development). When newer versions of psPAS are published and installed, this will prevent module changes from affecting script operation and allow any necessary code refactoring to be planned.

#### CHANGELOG

The [CHANGELOG](https://github.com/pspete/psPAS/blob/master/CHANGELOG.md) of the module contains details of all module updates and any notes relating to behaviour changes.

Check the module's release notes to determine if an issue you're experiencing is connected to any modifications that have been made to how the module works.
{: .notice--info}

## Manual API Command Testing

You can determine whether a problem is present just when using commands from the module or whether it also occurs when using native PowerShell to send requests to the API.
{: .notice--success}

This is accomplished by first authenticating with the API using psPAS (using `New-PASSession`), and then obtaining the same `WebSession` that psPAS would use for its subsequent API operations by using the `Get-PASSession` command.

Any request can be tested outside of the module by using the documentation to create and format the necessary details and by providing the obtained `WebSession` for API authorisation.

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

It typically means that there is nothing to address in the module itself if a problem is seen while using a module command and also when testing outside of the module (i.e. there is no fix which can be provided to the code or logic of the module).

If an issue is only observed when using the module, and tests outside the module are successful, [open an issue](#logging-an-issue) for investigation.
{: .notice--info}

## Logging an Issue
[Open a new issue](https://github.com/pspete/psPAS/issues/new?assignees=&labels=&template=issue-report.md&title=) to engage with the project on issues being faced with the usage of the psPAS tool itself.

Ensure all detail requested in the issue template is provided (but be sure to anonymise as required).
{: .notice--warning}

We can assist you more quickly if you provide the necessary information. By giving some basic information up front, we can quickly understand any factors that may impact the module's performance or operation.

Response and resolution times will be delayed if the template is not completed.

For problems that are unrelated to how the module operates, kindly utilise your usual support channels.

## Fixing Issues & Contributing to the Project

The good news is that you are welcome and encouraged to contribute your update if you have found a solution to an issue or a way to make psPAS better.

For complete instructions on how to send Pull Requests to the project for any improvements to code or documentation, see the [contributing guide](https://github.com/pspete/psPAS/blob/master/CONTRIBUTING.md).
