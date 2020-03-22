Clear-Host
Get-Job | Remove-Job # Clear any existing jobs

.\Split-File.ps1 -FilePath ".\Test-Files\valid.csv"

# Check if the script is being run in a normal console window, and if not, relaunch in a normal console window.
<# if ($Host.name -ne "ConsoleHost") {
    $CurrentScript = $MyInvocation.MyCommand.Definition
    $ps = Join-Path $PSHome 'powershell.exe'
    Start-Process $ps -ArgumentList "& '$CurrentScript'"

    # Stops execution of this process.
    # Only continues execution of this script if in a stand-alone console window.
    break
} #>

# The actual debug script you want to run in the new window

<# Set-Location $PSScriptRoot
$ProjectFolderName = Split-Path "$($PSScriptRoot)" -Leaf # Extract the folder name to use as a file-import name.
Import-Module $PSScriptRoot\$ProjectFolderName.psm1 # Import $ProjectFolderName.psm1 
 #>






# Press any key to exit, rather than having to press enter like with Read-Host.
# Doesn't work in ISE apparently. 
<# Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); #>