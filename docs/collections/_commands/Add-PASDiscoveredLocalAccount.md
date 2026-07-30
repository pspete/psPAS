---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASDiscoveredLocalAccount
schema: 2.0.0
---

# Add-PASDiscoveredLocalAccount

## SYNOPSIS
Add a specific account from the list of discovered local endpoint accounts to the Discovered Accounts list.

## SYNTAX

```
Add-PASDiscoveredLocalAccount [-type] <String> [-identifiers] <Hashtable> [[-isPrivileged] <Boolean>]
 [[-customProperties] <Hashtable>] [[-source] <String>] [-tags <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Adds a specific account from the list of discovered accounts for local endpoint Windows and MacOS accounts to the Discovered Accounts list.

Applies to the accounts that are discovered by the EPM scanning of endpoints, including loosely connected devices:
- Windows loosely connected devices
- Mac loosely connected devices
- Linux loosely connected devices

Requires one of the following roles:
- Privilege Cloud Administrator
- Privilege Cloud Administrator Basic
- Privilege Cloud Administrator Lite

## EXAMPLES

### EXAMPLE 1
```
Add-PASDiscoveredLocalAccount -type windows -identifiers @{'username'='administrator'; 'address'='somemachine.pspete.dev'}
```

Adds the specified local account as a discovered local account.

### EXAMPLE 2
```
Add-PASDiscoveredLocalAccount -type mac -identifiers @{'username'='root'; 'address'='mac01.pspete.dev'} -isPrivileged $true -source EPM
```

Adds the specified local Mac account, flagged as privileged, attributing the discovery to the EPM source.

### EXAMPLE 3
```
Add-PASDiscoveredLocalAccount -type unix -identifiers @{'username'='oracle'; 'address'='unixsrv01.pspete.dev'} -customProperties @{'Department'='Finance'; 'Owner'='Bob'}
```

Adds the specified local Unix account, including additional custom properties.

### EXAMPLE 4
```
$Accounts = @(
    [pscustomobject]@{type = 'windows'; identifiers = @{'username' = 'svc-web'; 'address' = 'web01.pspete.dev'} }
    [pscustomobject]@{type = 'windows'; identifiers = @{'username' = 'svc-sql'; 'address' = 'sql01.pspete.dev'} }
)
$Accounts | Add-PASDiscoveredLocalAccount
```

Adds multiple discovered local accounts, piping objects with type and identifiers properties.

## PARAMETERS

### -type
The type of the account

Valid values: windows, mac, unix


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -identifiers
List of properties that define the uniqueness of the account.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isPrivileged
Whether the user is privileged on the target.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -customProperties
List of additional account properties.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -source
The service which discovered the account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tags
List of tag(s) assigned to the discovered account by the scan definition.

```yaml
Type: String[]
Parameter Sets: (All)
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

[https://pspas.pspete.dev/commands/Add-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Add-PASDiscoveredLocalAccount)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-Add.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-Add.htm)
