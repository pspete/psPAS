---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccount
schema: 2.0.0
title: Get-PASAccount
---

# Get-PASAccount

## SYNOPSIS
Returns details of matching accounts. (Version 10.4 onwards)
Returns information about a single account. (Version 9.3 - 10.3)

## SYNTAX

### Gen2Query (Default)
```
Get-PASAccount [-search <String>] [-searchType <String>] [-safeName <String>] [-modificationTime <DateTime>]
 [-sort <String[]>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

### Gen2ID
```
Get-PASAccount -id <String> [-TimeoutSec <Int32>] [<CommonParameters>]
```

### Gen2Filter
```
Get-PASAccount [-search <String>] [-searchType <String>] [-sort <String[]>] [-offset <Int32>] [-limit <Int32>]
 [-filter <String>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

### Gen1
```
Get-PASAccount [-Keywords <String>] [-Safe <String>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Version 10.4+:
- This method returns a list of either a specific, or all the accounts in the Vault.

Version 9.3 - 10.3:
- Returns information about an account.
- If more than one account meets the search criteria,
only the first account will be returned (the Count output parameter will display the number
of accounts that were found).
- Only the following users can access this account:
  - Users who are members of the Safe where the account is stored.
  - Users who have access to this specific account.
  - The user who runs this web service requires the following permission in the Safe:
  - Retrieve account
- If ten or more accounts are found, the Count Output parameter will show 10.

Requires the following permission in the Safe:
- List accounts.

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccount
```

Returns all accounts on safes where your user has "List accounts" rights.

This will only work from version 10.4 onwards.

### EXAMPLE 2
```
Get-PASAccount -search XUser -searchType startswith
```

Returns all accounts starting with "XUser".

### EXAMPLE 3
```
Get-PASAccount -safeName TargetSafe
```

Returns all accounts from TargetSafe

### EXAMPLE 4
```
Get-PASAccount -safeName TargetSafe -modificationTime (Get-Date 03/06/2020) -search some
```

Returns all accounts from TargetSafe modified after 03/06/2020

### EXAMPLE 5
```
Get-PASAccount -filter "SafeName eq TargetSafe"
```

Specify a filter value to return all accounts found in "TargetSafe"

### EXAMPLE 6
```
Get-PASAccount -filter "SafeName eq 'TargetSafe'" -sort "userName desc"
```

Returns all accounts found in TargetSafe, sort by username in descending order.

### EXAMPLE 7
```
Get-PASAccount -Keywords root -Safe UNIX
```

Finds account(s) matching keywords in UNIX safe

### EXAMPLE 8
```
Get-PASAccount -Keywords xtest
```

Finds accounts matching the specified keyword.

Only the first matching account will be returned.

If multiple accounts are found, a warning will be displayed before the result

### EXAMPLE 9
```
Get-PASAccount -search root -sort name -offset 100 -limit 5
```

Returns all accounts matching "root", sorted by AccountName, Search results offset by 100 and limited to 5.

## PARAMETERS

### -id
A specific account ID to return details for.

```yaml
Type: String
Parameter Sets: Gen2ID
Aliases: AccountID

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
The search term or keywords.

```yaml
Type: String
Parameter Sets: Gen2Query, Gen2Filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -searchType
Get accounts that either contain or start with the value specified in the Search parameter.

```yaml
Type: String
Parameter Sets: Gen2Query, Gen2Filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -safeName
The name of the safe to return accounts from.

```yaml
Type: String
Parameter Sets: Gen2Query
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -modificationTime
Specify to only return details of accounts modified after this date/time

Documented as an option since 11.4

```yaml
Type: DateTime
Parameter Sets: Gen2Query
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort
Property or properties by which to sort returned accounts,
followed by asc (default) or desc to control sort direction.

Separate multiple properties with commas, up to a maximum of three properties.

```yaml
Type: String[]
Parameter Sets: Gen2Query, Gen2Filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -offset
An offset for the search results (to discard the first x results for instance).

```yaml
Type: Int32
Parameter Sets: Gen2Filter
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
Maximum number of returned accounts.

If not specified, the default value is 50.

The maximum number that can be specified is 1000.

When used together with the Offset parameter,
this value determines the number of accounts to return, starting from the first account that is returned.

```yaml
Type: Int32
Parameter Sets: Gen2Filter
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -filter
A filter for the search.

Requires format: "SafeName eq 'YourSafe'"

*depreciated parameter in psPAS - safeName & modifiedTime will automatically be set as filter values

```yaml
Type: String
Parameter Sets: Gen2Filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Keywords
Keyword to search for.

If multiple keywords are specified, the search will include all the keywords.

Separate keywords with a space.

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Safe
The name of a Safe to search that the authenticated user is authorized to access.

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TimeoutSec
See Invoke-WebRequest

Specify a timeout value in seconds

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
New functionality added in version 10.4, limited functionality before this version.

As of psPAS v2.5.1+, the use of 'limit' and 'offset' parameters is discouraged - nextLink functionality was added

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccount](https://pspas.pspete.dev/commands/Get-PASAccount)

