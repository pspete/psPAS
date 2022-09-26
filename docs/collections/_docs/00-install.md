---
title: "Installation"
permalink: /docs/install/
excerpt: "psPAS Download & Install Options"
last_modified_at: 2022-09-25T01:23:45-00:00
---

{% capture notice-text %}
- PowerShell Core, or Windows Powershell v5 (minimum)
- CyberArk PAS REST API/PVWA Web Service (available and accessible over HTTPS using TLS 1.2)
- A user who can authenticate and has the necessary Vault/Safe permissions.
{% endcapture %}

<div class="notice--info">
  <h2>Prerequisites:</h2>
  {{ notice-text | markdownify }}
</div>

Users can download psPAS from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

## Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module.

1. Open a PowerShell prompt

2. Execute the following command:

```powershell
Install-Module -Name psPAS -Scope CurrentUser
```

**PowerShell 5.0 or above** must be used to download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/).
{: .notice--warning}

## Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `psPAS`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

### PowerShell Gallery

- Download from the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/):
  - Run the PowerShell command `Save-Module -Name psPAS -Path C:\temp`
  - Copy the `C:\temp\psPAS` folder to your "Powershell Modules" directory of choice.

### psPAS Release

- [Download the latest GitHub release](https://github.com/pspete/psPAS/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `psPAS-v#.#.#` folder to `psPAS`
  - Copy the `psPAS` folder to your "Powershell Modules" directory of choice.

### psPAS Branch

- [Download ```GitHub Branch```](https://github.com/pspete/psPAS/archive/master.zip)
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
