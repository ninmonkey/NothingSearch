
function Get-NothingConfig {
    <#
   .synopsis
        Get Named Paths for EverythingSearch
    .notes
        if user has 'es.cmd' installed, it may be at: "gci ( Join-Path $Env:LOCALAPPDATA 'Microsoft\WindowsApps' )"
    .example
        # Find 'Everything(-version).ini
        > Get-NothingConfig
    .example
        # All saved settings, other than the ini itself.
        > Get-NothingConfig -Csv

            Bookmarks-1.5a.csv, Filters-1.5a.csv, Macros-1.5a.csv, Run History-1.5a.csv, Search History-1.5a.csv
    .example
        # longest/full list of all file
        > Get-NothingConfig -All -IncludeBackups
    .LINK
        Get-NothingConfig
    .LINK
        Get-NothingConfigContent
    #>
    [Alias( 'Ns.Get-Config' )]
    [OutputType( [System.IO.FileInfo] )]
    [CmdletBinding()]
    param(
        # Includes Csv
        [Alias('All')]
        [switch] $ListAll,

        # data files, the live search, filters, bookmarks, etc.
        [Alias('CsvOnly')]
        [switch] $ListCsv,

        # By default, it ignores 'foo.backup.csv'
        [switch] $IncludeBackups
    )
    process {
        $files = Get-ChildItem -Recurse:$false -path ( join-path $Env:AppData 'Everything' )
        if( -not $IncludeBackups ) { $files = $Files | ? Name -notmatch '\.backup\.' }

        if( $ListCsv ) {
            return $files | ?{ $_.Extension -in ('.csv') }
        }
        $files
            | Where-Object {
                if( $ListAll ) { return $true }
                if ( $_.Name -eq 'Everything.Ini' ) { return $true }
                if ( $_.Name -match 'Everything-[\d\.a]*\.ini$' ) { return $true }  # alpha versions change the name
                return $false
            }
            | Where-Object { $_.Extension -match '\.(ini|csv)' }
            | Where-Object { $_.Name -notmatch 'old' }
    }
}



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


function _Ns.Find-ConfigPathByName {
    <#
    .synopsis
        maps names like 'Bookmarks' their absolute paths: "${Env:AppData}\Everything\Bookmarks-1.5a.csv"
    .NOTES
        Maybe this should be resolve/convert? but it's private.
    .EXAMPLE
        > _Ns.Find-ConfigPathByName Filters
        # out: Join-Path $Env:AppData 'Everything\Bookmarks-1.5a.csv'
    #>
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
            [string] $ConfigName
    )
    end {
        $csv = Get-NothingConfig -ListCsv
        # auto map names
        foreach( $item in $csv ) {
            $autoName = @( $item.Name -split '-', 2 )[0]
            $autoName = $autoName -replace '\s*', ''
            if( $autoName -match $ConfigName ) {
                return $item
            }
        }
        # otherwise fall back to mapping
        switch( $ConfigName ) {
            'Everything.ini' { Get-NothingConfig; return }
            default {
                throw "Unhandled Config was not found: '$ConfigName'"
            }
        }
    }
}

