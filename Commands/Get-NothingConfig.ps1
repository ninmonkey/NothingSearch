
function Get-NothingConfig {
    <#
   .synopsis
        Get Named Paths for EverythingSearch
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
            | ?{
                if( $ListAll ) { return $true }
                $_.Name -eq 'Everything.Ini'
            }
            | Where-Object { $_.Extension -match '\.(ini|csv)' }
            | Where-Object { $_.Name -notmatch 'old' }
    }
}
