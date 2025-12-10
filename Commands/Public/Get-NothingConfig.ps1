
function Get-NothingConfig {
    <#
   .synopsis
        Get Named Paths for EverythingSearch
    .notes
        if user has 'es.cmd' installed, it may be at: "gci ( Join-Path $Env:LOCALAPPDATA 'Microsoft\WindowsApps' )"
    .example
        > Get-NothingConfig
    #>
    [Alias( 'Ns.Get-Config' )]
    [OutputType( [System.IO.FileInfo] )]
    [CmdletBinding()]
    param(
        # Includes Csv
        [Alias('All')]
        [switch] $ListAll
    )
    process {
        Get-ChildItem -path ( join-path $Env:AppData 'Everything' )
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
