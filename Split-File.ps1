<#
.SYNOPSIS
    Imports Indicators of Compromise (IOCs) from a specified CSV file. 
.DESCRIPTION
    Powershell Module to import Indicators of Compromise (IOCs) from a target CSV file.
.NOTES
    File Name : Import-IOCFromCSV.ps1
    Author    : Graeme Meyer (@graememeyer)
    Version   : 1.0
.LINK
    https://github.com/graememeyer/Import-IOCFromCSV
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [ValidateScript({Test-Path $_})]
    [string]
    $FilePath,
    [Parameter(Mandatory=$false)]
    [string] $ChunkSize
)
If(!$ChunkSize) {
    $ChunkSize = 20KB # calculated by Powershell
}
If($FilePath) {
    Try{
        $ResolvedPath = (Resolve-Path $FilePath | Select-Object $_.Path)
        Test-Path $ResolvedPath
        $Extension = [System.IO.Path]::GetExtension($ResolvedPath)
        $RootName = Split-Path $ResolvedPath -Leaf
        $FilePath = $ResolvedPath
    }
    Catch { 
        Write-Host "That ain't a valid file path. You done fucked up son."
        Break
    }
} else {
    Write-Host "That ain't a valid file path. You done fucked up son."
    Break
}

$Reader = new-object System.IO.StreamReader($FilePath)
$ChunkNumber = 1
$FileName = "{0}{1}{2}" -f ($RootName, $ChunkNumber, $Extension)
while(($Line = $Reader.ReadLine()) -ne $null)
{
    Add-Content -path $FileName -value $Line
    if((Get-ChildItem -path $FileName).Length -ge $ChunkSize)
    {
        ++$ChunkNumber
        $FileName = "{0}{1}.{2}" -f ($RootName, $ChunkNumber, $Extension)
    }
}
$Reader.Close()