

function Get-NothingConfigContent {
    <#
   .synopsis
        Read config files by an alias, mapping to the real filepaths for you
    .example
    .LINK
        Get-NothingConfig
    .LINK
        Get-NothingConfigContent
    #>
    [Alias( 'Ns.Get-ConfigContent' )]
    [OutputType(
        [PSCustomObject[]], # when: -not PassThru
        [string[]] # when: PassThru
    )]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
            [Alias('Name', 'Alias')]
            [ValidateSet(
                'Everything.ini',
                'Bookmarks',
                'Filters',
                'Macros',
                'RunHistory',
                'SearchHistory' )]
            [string] $ConfigName,

        # Return file as text, if automatic import does not work
        [switch] $RawText
    )
    end {
        $fullName = _Ns.Find-ConfigPathByName -ConfigName $ConfigName | Get-Item
        if( -not $FullName ) { throw "Error resolving '${ConfigName}' to path!" }

        if( $RawText ) { Get-Content -Raw $Fullname -Encoding Utf8 ; return; }
        Import-Csv -Path $FullName -Encoding Utf8
    }
}
