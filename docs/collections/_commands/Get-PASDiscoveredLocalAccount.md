---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDiscoveredLocalAccount
schema: 2.0.0
---

# Get-PASDiscoveredLocalAccount

## SYNOPSIS
List discovered unmanaged local Windows, macOS, and Linux accounts.

## SYNTAX

### byQuery (Default)
```
Get-PASDiscoveredLocalAccount [-search <String>] [-searchOnAllFields <Boolean>] [-type <String>]
 [-subtype <String>] [-isPrivileged <Boolean>] [-lastDiscoveryRulesStatus <String>]
 [-extendedDetails <Boolean>] [-sort <String>] [-limit <Int32>] [<CommonParameters>]
```

### byID
```
Get-PASDiscoveredLocalAccount -id <String> [<CommonParameters>]
```

## DESCRIPTION
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
```powershell
Get-PASDiscoveredLocalAccount
```

Get all discovered local accounts

### EXAMPLE 2
```powershell
Get-PASDiscoveredLocalAccount -id SomeID
```

Get specific discovered local account

## PARAMETERS

### -id
The unique identifier of the discovered account.

```yaml
Type: String
Parameter Sets: byID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
Search for the defined string in all identifier values of the discovered account.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -searchOnAllFields
Whether the search is performed in customProperties values as well.

```yaml
Type: Boolean
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -type
The type of the discovered local account

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subtype
The subtype of the discovered local account

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isPrivileged
Whether the account is privileged

```yaml
Type: Boolean
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -lastDiscoveryRulesStatus
The last status of the discovery rule

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extendedDetails
Whether to retrieve extended details from the discovered account's activities.

```yaml
Type: Boolean
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort
Sort according to identifier properties or customProperties, followed by asc (default) or desc to control the sort direction.
asc: ascending (default)
desc: descending

Example: 'username desc'

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
The maximum size of each page of search results

```yaml
Type: Int32
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASDiscoveredLocalAccount](https://pspas.pspete.dev/commands/Get-PASDiscoveredLocalAccount)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-GetAll.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-GetAll.htm)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-Get.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/Content/Privilege%20Cloud/PrivCloud-DiscoveredAccountsService-Get.htm)
