# Class definitions for Report subscribers

class LdapInfo {
    [string]$directoryName
    [string]$fullDN

    LdapInfo([string]$directoryName = $null, [string]$fullDN = $null) {
        $this.directoryName = $directoryName
        $this.fullDN = $fullDN
    }
}

class Subscriber {
    [string]$name
    [string]$type
    [bool]$notifyOnSuccess
    [LdapInfo]$ldapInfo

    Subscriber(
        [string]$name = $null,
        [string]$type = $null,
        [bool]$notifyOnSuccess = $false,
        [LdapInfo]$ldapInfo = $null
    ) {
        $this.name = $name
        $this.type = $type
        $this.notifyOnSuccess = $notifyOnSuccess
        $this.ldapInfo = $ldapInfo
    }

    static [Subscriber] AddSubscriber() {
        $SomeName = Read-Host "Enter subscriber name"
        $SomeType = Read-Host "Enter subscriber type"
        $notify = Read-Host "Notify on success? (true/false)"
        $SomeNotifyOnSuccess = $false
        if ($notify -match '^(true|false)$') {
            $SomeNotifyOnSuccess = [bool]::Parse($notify)
        }

        $useLdap = Read-Host "Add LDAP info? (yes/no)"
        $SomeLdapInfo = $null
        if ($useLdap -eq "yes") {
            $SomeDirectoryName = Read-Host "Enter LDAP directory name"
            $SomeFullDN = Read-Host "Enter full DN"
            $SomeLdapInfo = [LdapInfo]::new($SomeDirectoryName, $SomeFullDN)
        }

        return [Subscriber]::new($SomeName, $SomeType, $SomeNotifyOnSuccess, $SomeLdapInfo)
    }
}


$null = [Subscriber], [LdapInfo]
