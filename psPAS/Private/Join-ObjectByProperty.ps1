function Join-ObjectByProperty {
    <#
.SYNOPSIS
Merges two arrays of objects based on matching key property values.

.DESCRIPTION
For each object in PrimaryObjects, finds any objects in SecondaryObjects whose SecondaryKey property
(supports dotted paths, e.g. "general.id") matches the object's PrimaryKey property value, and merges
their properties into the output object. Properties already present on the primary object are not
overwritten by matching secondary object properties.
Property names listed in ExpandNested are treated as nested objects on the secondary object; rather than
being copied as-is, their own child properties are flattened into the output object.
If PrimaryObjects is null/empty, or has a Total property equal to 0, SecondaryObjects are returned instead,
flattened (and with ExpandNested still applied) but with no merge/matching performed.

.PARAMETER PrimaryObjects
Array of primary objects to merge from. Properties on these objects take precedence over any matching
properties found on merged SecondaryObjects.

.PARAMETER SecondaryObjects
Array of secondary objects to merge with. Optional.

.PARAMETER PrimaryKey
Property name on the primary objects used for matching against SecondaryKey.

.PARAMETER SecondaryKey
Property name (or dotted path, e.g. "general.id") on the secondary objects used for matching against PrimaryKey.

.PARAMETER ExpandNested
Names of nested properties in secondary objects to expand into the root level, instead of being copied as-is.

.EXAMPLE
Join-ObjectByProperty -PrimaryObjects $Platforms -SecondaryObjects $PlatformDetails -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

Merges $PlatformDetails into $Platforms, matching $PlatformDetails.general.id to $Platforms.PlatformID.

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = 'Array of primary objects to merge from.')]
        [AllowNull()]
        [object[]]
        $PrimaryObjects,

        [Parameter(HelpMessage = 'Array of secondary objects to merge with. Optional.')]
        [AllowNull()]
        [object[]]
        $SecondaryObjects,

        [Parameter(Mandatory, HelpMessage = 'Property name in primary objects used for matching.')]
        [ValidateNotNullOrEmpty()]
        [string]
        $PrimaryKey,

        [Parameter(Mandatory, HelpMessage = 'Property name in secondary objects used for matching.')]
        [ValidateNotNullOrEmpty()]
        [string]
        $SecondaryKey,

        [Parameter(HelpMessage = 'Names of nested properties in secondary objects to expand into the root level.')]
        [ValidateNotNull()]
        [string[]]
        $ExpandNested
    )


    function Get-DottedPropertyValue {
        param(
            [object]$InputObject,
            [string]$Path
        )

        $value = $InputObject

        foreach ($segment in $Path -split '\.') {
            if ($null -eq $value) {
                return $null
            }
            $value = $value.$segment
        }

        return $value
    }

    if (-not $PrimaryObjects -or $PrimaryObjects.Total -eq 0) {
        $fallbackOutput = [Collections.Generic.List[Object]]::New()

        foreach ($secondaryObject in $SecondaryObjects) {
            $flattened = [ordered]@{}

            foreach ($property in $secondaryObject.PSObject.Properties) {
                if (-not ($ExpandNested -contains $property.Name)) {
                    $flattened[$property.Name] = $property.Value
                }
            }

            foreach ($nestedPropertyName in $ExpandNested) {
                $nestedObject = $secondaryObject.$nestedPropertyName
                if ($nestedObject -and $nestedObject -is [PSCustomObject]) {
                    foreach ($property in $nestedObject.PSObject.Properties) {
                        if (-not $flattened.Contains($property.Name)) {
                            $flattened[$property.Name] = $property.Value
                        }
                    }
                }
            }

            $fallbackOutput.Add([PSCustomObject]$flattened)
        }

        return $fallbackOutput
    }

    $mergedOutput = [Collections.Generic.List[Object]]::New()

    foreach ($primaryObject in $PrimaryObjects) {
        $mergedObject = [ordered]@{}

        foreach ($property in $primaryObject.PSObject.Properties) {
            $mergedObject[$property.Name] = $property.Value
        }

        $matchingSecondaryObjects = $SecondaryObjects | Where-Object {
            (Get-DottedPropertyValue -InputObject $_ -Path $SecondaryKey) -eq $primaryObject.$PrimaryKey
        }

        if ($matchingSecondaryObjects) {
            foreach ($secondaryObject in $matchingSecondaryObjects) {
                foreach ($property in $secondaryObject.PSObject.Properties) {
                    if (-not $mergedObject.Contains($property.Name) -and -not ($ExpandNested -contains $property.Name)) {
                        $mergedObject[$property.Name] = $property.Value
                    }
                }

                foreach ($nestedPropertyName in $ExpandNested) {
                    $nestedObject = $secondaryObject.$nestedPropertyName
                    if ($nestedObject -and $nestedObject -is [PSCustomObject]) {
                        foreach ($property in $nestedObject.PSObject.Properties) {
                            if (-not $mergedObject.Contains($property.Name)) {
                                $mergedObject[$property.Name] = $property.Value
                            }
                        }
                    }
                }
            }
        }

        $mergedOutput.Add([PSCustomObject]$mergedObject)
    }

    return $mergedOutput
}
