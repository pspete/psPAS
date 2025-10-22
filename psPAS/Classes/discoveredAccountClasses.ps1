<#
.EXAMPLE
$query1 = [DiscoveredAccount]::new(
    "windows",
    "loosely",
    [Identifier]::new("win-computer.cyber-ark.com", "admin"),
    "user_account_5924"
)

$query2 = [DiscoveredAccount]::new(
    "mac",
    "loosely",
    [Identifier]::new("mac-computer.cyber-ark.com", "root"),
    "user_account_1132"
)

# Output as JSON array
$queries = @($query1, $query2)
$queries | ConvertTo-Json -Depth 3
#>
class Identifier {
    [string]$address
    [string]$username

    Identifier([string]$address, [string]$username) {
        $this.address = $address
        $this.username = $username
    }
}

class DiscoveredAccount {
    [string]$type
    [string]$subType
    [Identifier]$identifiers
    [string]$externalId

    DiscoveredAccount([string]$type, [string]$subType, [Identifier]$identifiers, [string]$externalId) {
        $this.type = $type
        $this.subType = $subType
        $this.identifiers = $identifiers
        $this.externalId = $externalId
    }

    [string]ToJson() {
        return $this | ConvertTo-Json -Depth 3
    }
}
