---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASDependentAccount
schema: 2.0.0
---

# Get-PASDependentAccount

## SYNOPSIS
Returns details of dependent accounts.

## SYNTAX

### SpecificDependentAccount
```
Get-PASDependentAccount -id <String> -dependentAccountId <String> [-extendedDetails <Boolean>]
 [-TimeoutSec <Int32>] [<CommonParameters>]
```

### SpecificAccount
```
Get-PASDependentAccount -id <String> [-search <String>] [-modificationTime <DateTime>] [-platformId <String>]
 [-failed <Boolean>] [-TimeoutSec <Int32>] [<CommonParameters>]
```

### AllDependentAccounts
```
Get-PASDependentAccount [-search <String>] [-MasterAccountId <String>] [-modificationTime <DateTime>]
 [-platformId <String>] [-SafeName <String>] [-includeDeleted <Boolean>] [-limit <Int32>] [-TimeoutSec <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns details of dependent accounts.

Can return all dependent accounts, specific dependent accounts, or details fo dependent accounts associated with a specific master account

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PASDependentAccount
```

Returns all Dependent Accounts

### Example 2
```powershell
PS C:\> Get-PASDependentAccount -id 12_34
```

Returns all Dependent Accounts of Account with id 12_34

### Example 3
```powershell
PS C:\> Get-PASDependentAccount -id 12_34 -dependentAccountId 12_78
```

Returns Dependent Account with id of 12_78 of Account with id 12_34

## PARAMETERS

### -id
The account ID of the master account

```yaml
Type: String
Parameter Sets: SpecificDependentAccount, SpecificAccount
Aliases: AccountID

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -dependentAccountId
The unique ID of the dependent account

```yaml
Type: String
Parameter Sets: SpecificDependentAccount
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
A list of keywords to search for in accounts, separated by a space.

```yaml
Type: String
Parameter Sets: SpecificAccount, AllDependentAccounts
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MasterAccountId
The parent account ID of the dependent accounts to return.

```yaml
Type: String
Parameter Sets: AllDependentAccounts
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -modificationTime
Date after which the dependent account was modified.

```yaml
Type: DateTime
Parameter Sets: SpecificAccount, AllDependentAccounts
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformId
Unique identifier of the dependent platform.

```yaml
Type: String
Parameter Sets: SpecificAccount, AllDependentAccounts
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SafeName
The Safe name of the dependent account.

```yaml
Type: String
Parameter Sets: AllDependentAccounts
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -includeDeleted
Whether to include deleted accounts in the results or not.

```yaml
Type: Boolean
Parameter Sets: AllDependentAccounts
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -failed
Get only failed dependent accounts.

```yaml
Type: Boolean
Parameter Sets: SpecificAccount
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extendedDetails
Whether to retrieve Linked Accounts data or not

```yaml
Type: Boolean
Parameter Sets: SpecificDependentAccount
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
The maximum number of dependent accounts to return in each page of results

```yaml
Type: Int32
Parameter Sets: AllDependentAccounts
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TimeoutSec
Timeout in seconds for the request

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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASDependentAccount](https://pspas.pspete.dev/commands/Get-PASDependentAccount)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-all-dependent-accounts.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-all-dependent-accounts.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-all-dependent-accounts-specific.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-all-dependent-accounts-specific.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-dependent-account-details.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/get-dependent-account-details.htm)