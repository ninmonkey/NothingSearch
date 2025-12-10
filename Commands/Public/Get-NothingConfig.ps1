
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
