---
title: Get-PASAccount
---

## SYNOPSIS

    Returns details of matching accounts. (Version 10.4 onwards)
    Returns information about a single account. (Version 9.3 - 10.3)

## SYNTAX

    Get-PASAccount [-search <String>] [-searchType <String>] [-safeName <String>] [-modificationTime <DateTime>]
    [-sort <String[]>] [-TimeoutSec <Int32>] [<CommonParameters>]

    Get-PASAccount -id <String> [-TimeoutSec <Int32>] [<CommonParameters>]

    Get-PASAccount [-search <String>] [-searchType <String>] [-sort <String[]>] [-offset <Int32>] [-limit <Int32>]
    [-filter <String>] [-TimeoutSec <Int32>] [<CommonParameters>]

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

    -search <String>
        The search term or keywords.

    -searchType <String>
        Get accounts that either contain or start with the value specified in the Search parameter.

    -safeName <String>
        The name of the safe to return accounts from.

    -modificationTime <DateTime>
        Specify to only return details of accounts modified after this date/time
        Documented as an option since 11.4

    -sort <String[]>
        Property or properties by which to sort returned accounts,
        followed by asc (default) or desc to control sort direction.
        Separate multiple properties with commas, up to a maximum of three properties.

    -offset <Int32>
        An offset for the search results (to discard the first x results for instance).
        *depreciated parameter in psPAS - nextLink functionality will fetch all results automatically

    -limit <Int32>
        Maximum number of returned accounts. If not specified, the default value is 50.
        The maximum number that can be specified is 1000. When used together with the Offset parameter,
        this value determines the number of accounts to return, starting from the first account that is returned.
        *depreciated parameter in psPAS - nextLink functionality will fetch all results automatically

    -filter <String>
        A filter for the search.
        Requires format: "SafeName eq 'YourSafe'"
        *depreciated parameter in psPAS - safeName & modifiedTime will automatically be set as filter values

    -Keywords <String>
        Keyword to search for.
        If multiple keywords are specified, the search will include all the keywords.
        Separate keywords with a space.
        Relevant for CyberArk versions earlier than 10.4

    -Safe <String>
        The name of a Safe to search that the authenticated user is authorized to access.
        Relevant for CyberArk versions earlier than 10.4

    -TimeoutSec <Int32>
        See Invoke-WebRequest
        Specify a timeout value in seconds

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

    PS C:\>Get-PASAccount -search XUser -searchType startswith

    Returns all accounts starting with "XUser".




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASAccount -safeName TargetSafe

    Returns all accounts from TargetSafe




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASAccount -safeName TargetSafe -modificationTime (Get-Date 03/06/2020) -search some

    Returns all accounts from TargetSafe modified after 03/06/2020




    -------------------------- EXAMPLE 5 --------------------------

    PS C:\>Get-PASAccount -filter "SafeName eq TargetSafe"

    Specify a filter value to return all accounts found in "TargetSafe"




    -------------------------- EXAMPLE 6 --------------------------

    PS C:\>Get-PASAccount -filter "SafeName eq 'TargetSafe'" -sort "userName desc"

    Returns all accounts found in TargetSafe, sort by username in descending order.




    -------------------------- EXAMPLE 7 --------------------------

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




    -------------------------- EXAMPLE 8 --------------------------

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




    -------------------------- EXAMPLE 9 --------------------------

    PS C:\>Get-PASAccount -search root -sort name -offset 100 -limit 5

    Returns all accounts matching "root", sorted by AccountName, Search results offset by 100 and limited to 5.
    *depreciated parameter in psPAS - nextLink functionality will fetch all results automatically
