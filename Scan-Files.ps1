# Folder section windows declaration
Add-Type -AssemblyName System.Windows.Forms
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog

function Scan-Files($FolderPath){
    [string]$TimeStamp = Get-Date -UFormat '%y%m%d-%H%M%S'
    [string]$LogFile = "$PSScriptRoot\Scan-Files-Results-(YYMMDD-HHMMSS)-($TimeStamp)"+".csv"
    if(Test-Path "$PSScriptRoot\sigcheck.exe"){
        Write-Host "Found sigcheck, starting a recursive scan of executable objects only..." -fo Green
        Start-Process "$PSScriptRoot\sigcheck.exe" -Wait -ArgumentList " -c -u -e -s -vt -vs `"$FolderPath`"" -RedirectStandardOutput $LogFile
        Import-Csv -LiteralPath $LogFile | ogv
    }
    else{
        Write-Host "FAILURE: Cannot locate sigcheck.exe !!!" -NoNewline -fo Red 
        Write-Host " Download a copy from https://technet.microsoft.com/en-us/sysinternals/bb897441.aspx and place it in the script directory." 
    }
}

# Call folder window dialog
[void]$FolderBrowser.ShowDialog()

# Prevent canceled selection from causing a malfunction
if ($FolderBrowser.SelectedPath -like "*:*"){
    Scan-Files ($FolderBrowser.SelectedPath)
}

else {
    Write-Host "No folder selected..." -fo Red
    exit
}
