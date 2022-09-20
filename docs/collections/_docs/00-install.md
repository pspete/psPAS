---
title: "Installation"
permalink: /docs/install/
excerpt: "psPAS Download & Install Options"
last_modified_at: 2022-09-20T01:23:45-00:00
---

{% capture notice-text %}
- PowerShell Core, or Windows Powershell v5 (minimum)
- CyberArk PAS REST API/PVWA Web Service (available and accessible over HTTPS using TLS 1.2)
- A user with appropriate Vault/Safe permissions, with which to authenticate.
{% endcapture %}

<div class="notice--info">
  <h2>Prerequisites:</h2>
  {{ notice-text | markdownify }}
</div>

psPAS is available to download from either the PowerShell Gallery or GitHub.

Choose one of the following methods to obtain & install the module:

## Option 1: Install from PowerShell Gallery

This is the simplest & preferred method for installation of the module.

1. Open a PowerShell prompt

2. Execute the following command:

```powershell
Install-Module -Name psPAS -Scope CurrentUser
```

**PowerShell 5.0 or above** must be used to download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/).
{: .notice--warning}

## Option 2: Manual Install

You can manually copy the module files to one of your powershell module folders.

Find your PowerShell Module Paths with the following command:

```powershell

$env:PSModulePath.split(';')

```

The module files should be placed in a folder named `psPAS` in one of the listed locations

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

There are multiple options for downloading the module files:

### PowerShell Gallery

- Download from the module [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/):
  - Run the PowerShell command `Save-Module -Name psPAS -Path C:\temp`
  - Copy the `C:\temp\psPAS` folder to your "Powershell Modules" directory of choice.

### psPAS Release

- [Download the latest release](https://github.com/pspete/psPAS/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `psPAS-v#.#.#` folder to `psPAS`
  - Copy the `psPAS` folder to your "Powershell Modules" directory of choice.

### psPAS Branch

- [Download the ```master branch```](https://github.com/pspete/psPAS/archive/master.zip)
  - Unblock & Extract the archive
  - Copy the `psPAS` (`\<Archive Root>\psPAS-master\psPAS`) folder to your "Powershell Modules" directory of choice.

## Verification

Validate Install:

```powershell

Get-Module -ListAvailable psPAS

```

Import the module:

```powershell

Import-Module psPAS

```

List Module Commands:

```powershell

Get-Command -Module psPAS

```

Get detailed information on specific commands:

```powershell

Get-Help New-PASUser -Full

```
