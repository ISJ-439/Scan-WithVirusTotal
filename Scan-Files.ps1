# Paramiters For Script
$NetworkDumpDir = 'Z:'

# Initialize Variable Paramiters\
[string]$PCName = $env:COMPUTERNAME
[string]$TimeStamp = Get-Date -UFormat '%y%m%d-%H%M%S'
[string]$LogFile = "$NetworkDumpDir\Scan-Files-Results-(YYMMDD-HHMMSS)-($TimeStamp)_For($PCName)"+".csv"

# Start Process
Start-Process "C:\Scan-Files\sigcheck.exe" -Wait -ArgumentList " -c -u -e -s -vt -vs `"C:\`"" -RedirectStandardOutput $LogFile