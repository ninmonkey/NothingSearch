
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
