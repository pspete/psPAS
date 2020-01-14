---
title: Get-PASAccount
---

## SYNOPSIS

    Returns details of matching accounts. (Version 10.4 onwards)
    Returns information about a single account. (Version 9.3 - 10.3)

## SYNTAX

    Get-PASAccount [-search <String>] [-searchType <String>] [-sort <String[]>] [-offset <Int32>] [-limit <Int32>]
    [-filter <String>] [-TimeoutSec <Int32>] [<CommonParameters>]

    Get-PASAccount -id <String> [-TimeoutSec <Int32>] [<CommonParameters>]

    Get-PASAccount [-Keywords <String>] [-Safe <String>] [-TimeoutSec <Int32>] [<CommonParameters>]

## DESCRIPTION

    Version 10.4+:
    This method returns a list of either a specific, or all the accounts in the Vault.
    Requires the following permission in the Safe: List accounts.

    Version 9.3 - 10.3:
    Returns information about an account. If more than one account meets the search criteria,
    only the first account will be returned (the Count output parameter will display the number
    of accounts that were found).
    Only the following users can access this account:
        - Users who are members of the Safe where the account is stored
        - Users who have access to this specific account.
        - The user who runs this web service requires the following permission in the Safe:
        - Retrieve account
    This method does not display the actual password.
    If ten or more accounts are found, the Count Output parameter will show 10.

## PARAMETERS

    -id <String>
        A specific account ID to return details for.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -search <String>
        The search term or keywords.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -searchType <String>
        Get accounts that either contain or start with the value specified in the Search parameter.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -sort <String[]>
        Property or properties by which to sort returned accounts,
        followed by asc (default) or desc to control sort direction.
        Separate multiple properties with commas, up to a maximum of three properties.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -offset <Int32>
        An offset for the search results (to discard the first x results for instance).

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -limit <Int32>
        Maximum number of returned accounts. If not specified, the default value is 50.
        The maximum number that can be specified is 1000. When used together with the Offset parameter,
        this value determines the number of accounts to return, starting from the first account that is returned.

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -filter <String>
        A filter for the search.
        Requires format: "SafeName eq 'YourSafe'"

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Keywords <String>
        Keyword to search for.
        If multiple keywords are specified, the search will include all the keywords.
        Separate keywords with a space.
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Safe <String>
        The name of a Safe to search. The search will be carried out only in the Safes in the Vault
        that the authenticated used is authorized to access.
        Relevant for CyberArk versions earlier than 10.4

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TimeoutSec <Int32>
        See Invoke-WebRequest
        Specify a timeout value in seconds

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASAccount

    Returns  all accounts on safes where your user has "List accounts" rights.
    This will only work from version 10.4 onwards.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASAccount -search root -sort name -offset 100 -limit 5

    Returns all accounts matching "root", sorted by AccountName, Search results offset by 100 and limited to 5.




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASAccount -search XUser -searchType startswith

    Returns all accounts starting with "XUser".




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASAccount -filter "SafeName eq TargetSafe"

    Returns all accounts found in TargetSafe




    -------------------------- EXAMPLE 5 --------------------------

    PS C:\>Get-PASAccount -filter "SafeName eq 'TargetSafe'" -sort "userName desc"

    Returns all accounts found in TargetSafe, sort by username in descending order.




    -------------------------- EXAMPLE 6 --------------------------

    PS C:\>Get-PASAccount -Keywords root -Safe UNIX

    Finds account(s) matching keywords in UNIX safe:

    AccountID  : 19_6
    Safe       : UNIX
    Folder     : Root
    Name       : UNIXSSH-machine-root
    UserName   : root
    PlatformID : UNIXSSH
    DeviceType : Operating System
    Address    : machine




    -------------------------- EXAMPLE 7 --------------------------

    PS C:\>Get-PASAccount -Keywords xtest

    Finds accounts matching the specified keyword.
    Only the first matching account will be returned.
    If multiple accounts are found, a warning will be displayed before the result:

    WARNING: 3 matching accounts found. Only the first result will be returned

    AccountID  : 19_9
    Safe       : TestSafe
    Folder     : Root
    Name       : Application-Cyberark-10.10.10.20-xTest3
    UserName   : xTest3
    PlatformID : Cyberark
    DeviceType : Application
    Address    : 10.10.10.20
