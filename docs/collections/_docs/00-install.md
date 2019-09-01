---
title: "Installation"
permalink: /docs/install/
excerpt: "psPAS Download & Install Options"
last_modified_at: 2019-09-01T01:33:52-00:00
---

{% capture notice-text %}
- Requires Powershell v3 (minimum)
- CyberArk PAS REST API/Web Service
- A user with which to authenticate, with appropriate Vault/Safe permissions.
{% endcapture %}

<div class="notice--info">
  <h2>Prerequisites:</h2>
  {{ notice-text | markdownify }}
</div>

psPAS is available to download from either the PowerShell Gallery or GitHub.

Choose one of the following methods to obtain & install the module:

## Option 1: Install from PowerShell Gallery

1. Open a PowerShell prompt

2. Execute the following command:

```powershell
Install-Module -Name psPAS -Scope CurrentUser
```

**PowerShell 5.0 or above is required** to download the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/).
{: .notice--warning}

## Option 2: Manual Install

1. Download the [`master branch`](https://github.com/pspete/psPAS/archive/master.zip) archive file from [GitHub](https://github.com/pspete/psPAS/).

2. Extract the `psPAS-master.zip` archive

{% capture notice-text %}

- The downloaded `psPAS-master.zip` archive contains a folder named **`psPAS`**.

- The **`psPAS`** folder must be copied to one of your PowerShell Module Directories.
  - Find your PowerShell Module Paths with the `$env:PSModulePath.split(';')` command:
- Copy the `psPAS` folder to your "Powershell Modules" directory of choice.

{% endcapture %}
<div class="notice--info">
  {{ notice-text | markdownify }}
</div>

## Verification

Validate Module Exists on your local machine:

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
