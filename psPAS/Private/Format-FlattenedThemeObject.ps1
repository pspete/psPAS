function Format-FlattenedThemeObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNull()]
        [PSCustomObject]$InputObject,

        [switch]$AsHashtable
    )

    begin {

        function Add-ThemeProperty {
            param (
                [PSCustomObject]$Source,
                [hashtable]$Target,
                [string]$Suffix = ''
            )
            foreach ($prop in $Source.PSObject.Properties) {
                $name = if ($Suffix) { "$($prop.Name)_$Suffix" } else { $prop.Name }
                $Target[$name] = $prop.Value
            }
        }

        $flatProps = @{}

    }

    process {

        # Top-level props
        $flatProps.name        = $InputObject.name
        $flatProps.isDraft     = $InputObject.isDraft
        $flatProps.colorsStyle = $InputObject.colors.colorsStyle

        # Inject nested props
        Add-ThemeProperty -Source $InputObject.images.main -Target $flatProps

        $definitionMap = @{
            dark   = 'Dark'
            bright = 'Bright'
        }
        foreach ($key in $definitionMap.Keys) {
            Add-ThemeProperty -Source $InputObject.colors.definitionByType.$key -Target $flatProps -Suffix $definitionMap[$key]
        }

        $colorSections = 'main', 'menu', 'advanced'
        foreach ($section in $colorSections) {
            Add-ThemeProperty -Source $InputObject.colors.$section -Target $flatProps
        }


    }
    End{
        if ($AsHashtable) {
            return $flatProps
        } else {
            return [PSCustomObject]$flatProps
        }
    }
}