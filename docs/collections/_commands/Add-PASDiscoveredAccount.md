---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASDiscoveredAccount
schema: 2.0.0
title: Add-PASDiscoveredAccount
---

# Add-PASDiscoveredAccount

## SYNOPSIS
Adds discovered account or SSH key as a pending account in the accounts feed.

## SYNTAX

### Windows (Default)
```
Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
 -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
 [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>] [-passwordNeverExpires <Boolean>]
 [-OSVersion <String>] [-privileged <Boolean>] [-privilegedCriteria <String>] [-UserDisplayName <String>]
 [-description <String>] [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
 [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-SID <String>] [<CommonParameters>]
```

### UnixSSHKey
```
Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
 -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
 [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>] [-passwordNeverExpires <Boolean>]
 [-OSVersion <String>] [-privileged <Boolean>] [-privilegedCriteria <String>] [-UserDisplayName <String>]
 [-description <String>] [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
 [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-uid <String>] [-gid <String>]
 -fingerprint <String> [-size <Int32>] [-path <String>] [-format <String>] [-comment <String>]
 [-encryption <String>] [<CommonParameters>]
```

### Unix
```
Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
 -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
 [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>] [-passwordNeverExpires <Boolean>]
 [-OSVersion <String>] [-privileged <Boolean>] [-privilegedCriteria <String>] [-UserDisplayName <String>]
 [-description <String>] [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
 [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-uid <String>] [-gid <String>]
 [<CommonParameters>]
```

### AWS
```
Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
 -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
 [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>] [-passwordNeverExpires <Boolean>]
 [-OSVersion <String>] [-privileged <Boolean>] [-privilegedCriteria <String>] [-UserDisplayName <String>]
 [-description <String>] [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
 [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-awsAccountID <String>]
 [-awsAccessKeyID <String>] [<CommonParameters>]
```

### Dependency
```
Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
 -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
 [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>] [-passwordNeverExpires <Boolean>]
 [-OSVersion <String>] [-privileged <Boolean>] [-privilegedCriteria <String>] [-UserDisplayName <String>]
 [-description <String>] [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
 [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-Dependencies <Hashtable[]>]
 [<CommonParameters>]
```

### Azure
```
Add-PASDiscoveredAccount -UserName <String> -Address <String> -discoveryDate <DateTime>
 -AccountEnabled <Boolean> [-osGroups <String>] [-platformType <String>] [-Domain <String>]
 [-lastLogonDateTime <DateTime>] [-lastPasswordSetDateTime <DateTime>] [-passwordNeverExpires <Boolean>]
 [-OSVersion <String>] [-privileged <Boolean>] [-privilegedCriteria <String>] [-UserDisplayName <String>]
 [-description <String>] [-passwordExpirationDateTime <DateTime>] [-osFamily <String>]
 [-additionalProperties <Hashtable>] [-organizationalUnit <String>] [-activeDirectoryID <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Enables an account or SSH key that is discovered by an external scanner to be added
as a pending account to the Accounts Feed.

Users can identify privileged accounts and determine which are on-boarded to the vault.

## EXAMPLES

### EXAMPLE 1
```
Add-PASDiscoveredAccount -UserName Discovered23 -Address domain.com -discoveryDate $(Get-Date "29/10/2018") -AccountEnabled $true -platformType "Windows Domain" -SID 12355
```

Adds matching discovered account as pending account.

### EXAMPLE 2
```
Add-PASDiscoveredAccount -UserName AWSUser -Address aws.com -discoveryDate (Get-Date 1/1/1974) -AccountEnabled $true -platformType AWS -awsAccountID 123456777889 -privileged $false
```

Adds matching account to pending/discovered account list.

### EXAMPLE 3
```
$dependency = @()

$dependency += @{
"name"="SomeDependency"
"address"="1.2.3.4"
"type"="Windows Service"
}
$dependency += @{
"name"="Some"
"address"="1.2.3.4"
"type"="Windows Scheduled Task"
"taskFolder"="\Some\Folder"
}
Add-PASDiscoveredAccount -UserName ServiceUser -Address 1.2.3.4 -discoveryDate (Get-Date 25/3/2013) -AccountEnabled $true -platformType 'Windows Server Local' -Dependencies $dependency
```

Adds or updates matching pending account with defined dependencies.

## PARAMETERS

### -UserName
The name of the account user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Address
The name or address of the machine where the account is located.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -discoveryDate
The date the account was discovered.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccountEnabled
The state of the account, defined in the discovery source.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -osGroups
The name of the group the account belongs to, such as Administrators or Operators.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformType
The platform where the discovered account is located.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Domain
The domain of the account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -lastLogonDateTime
The date this account was last logged into, defined in the discovery source.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -lastPasswordSetDateTime
The date this password was last set, defined in the discovery source.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordNeverExpires
Whether or not this password expires, defined in the discovery source.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OSVersion
The version of the OS where the account was discovered.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -privileged
Whether the discovered account is privileged or non-privileged.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -privilegedCriteria
The criteria that determines whether or not the discovered account is privileged.

For example, the user or group name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserDisplayName
The user's display name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
A description of the account, defined in the discovery source.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordExpirationDateTime
The expiration date of the account, defined in the discovery source.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -osFamily
The type of machine where the account was discovered.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -additionalProperties
A hashtable of additional properties added to the account.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -organizationalUnit
The organizational unit where the account is defined.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SID
Security ID.

This parameter is relevant only for Windows accounts.

Relevant when platformType is set to Windows

```yaml
Type: String
Parameter Sets: Windows
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -uid
The unique user ID.

This parameter is relevant only for Unix accounts.

Relevant when platformType is set to "Unix" or "Unix SSH Key"

```yaml
Type: String
Parameter Sets: UnixSSHKey, Unix
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -gid
The unique group ID.

This parameter is relevant only for Unix accounts.

Relevant when platformType is set to "Unix" or "Unix SSH Key"

```yaml
Type: String
Parameter Sets: UnixSSHKey, Unix
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -fingerprint
The fingerprint of the discovered SSH key.

The public and private keys of the same trust have the same fingerprint.

This is relevant for SSH keys only.

Relevant when platformType is set to "Unix SSH Key"

```yaml
Type: String
Parameter Sets: UnixSSHKey
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -size
The size in bits of the generated key.

Relevant when platformType is set to "Unix SSH Key"

```yaml
Type: Int32
Parameter Sets: UnixSSHKey
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -path
The path of the public key on the target machine.

Relevant when platformType is set to "Unix SSH Key"

```yaml
Type: String
Parameter Sets: UnixSSHKey
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -format
The format of the private SSH key.

Relevant when platformType is set to "Unix SSH Key"

```yaml
Type: String
Parameter Sets: UnixSSHKey
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -comment
Any text added when the key was created.

Relevant when platformType is set to "Unix SSH Key"

```yaml
Type: String
Parameter Sets: UnixSSHKey
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -encryption
The type of encryption used to generate the SSH key.

Relevant when platformType is set to "Unix SSH Key"

```yaml
Type: String
Parameter Sets: UnixSSHKey
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -awsAccountID
The AWS Account ID, in the format of a 12-digit number.

Relevant when platformType is set to AWS or AWS Access Keys

Minimum required version 10.8

```yaml
Type: String
Parameter Sets: AWS
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -awsAccessKeyID
The AWS Access Key ID string

Relevant when platformType is set to AWS or AWS Access Keys

Minimum required version 10.8

```yaml
Type: String
Parameter Sets: AWS
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Dependencies
Accepts hashtable representing key/value pairs for:
- name: the Name of the dependency
- address (mandatory): IP address or DNS hostname of the dependency
- type (mandatory): The dependency type from the following list:
  - COM+ Application
  - IIS Anonymous Authentication
  - IIS Application Pool
  - Windows Scheduled Task
  - Windows Service
- taskFolder: The dependency task folder, relevant for Windows Scheduled Tasks.

Minimum required version 10.8

```yaml
Type: Hashtable[]
Parameter Sets: Dependency
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -activeDirectoryID
Azure Active Directory tenant ID

Minimum required version 11.7

```yaml
Type: String
Parameter Sets: Azure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASDiscoveredAccount](https://pspas.pspete.dev/commands/Add-PASDiscoveredAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Discovered%20Account%20v10.8.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Discovered%20Account%20v10.8.htm)
