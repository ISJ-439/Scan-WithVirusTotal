<#
### From sigcheck help ###

usage: sigcheck.exe [-a][-h][-i][-e][-l][-n][[-s]|[-c|-ct]|[-m]][-q][-r][-u][-vt][-v[r][s]][-f catalog file] <file or directory>
usage: sigcheck.exe [-d][-c|-ct] <file or directory>
usage: sigcheck.exe [-t[u]] <certificate store name|*>
  -a      Show extended version information. The entropy measure reported
          is the bits per byte of information of the file's contents.
  -c      CSV output with comma delimiter
  -ct     CSV output with tab delimiter
  -d      Dump contents of a catalog file
  -e      Scan executable images only (regardless of their extension)
  -f      Look for signature in the specified catalog file
  -h      Show file hashes
  -i      Show catalog name and image signers
  -l      Traverse symbolic links and directory junctions
  -m      Dump manifest
  -n      Only show file version number
  -q      Quiet (no banner)
  -r      Disable check for certificate revocation
  -s      Recurse subdirectories
  -t[u]   Dump contents of specified certificate store ('*' for all stores).
          Specify -tu to query the user store (machine store is the default).
  -u      If VirusTotal check is enabled, show files that are unknown
          by VirusTotal or have non-zero detection, otherwise show only
          unsigned files.
  -v[rs]  Query VirusTotal (www.virustotal.com) for malware based on file hash.
          Add 'r' to open reports for files with non-zero detection. Files
          reported as not previously scanned will be uploaded to VirusTotal
          if the 's' option is specified. Note scan results may not be
          available for five or more minutes.
  -vt     Before using VirusTotal features, you must accept
          VirusTotal terms of service. See:

          https://www.virustotal.com/en/about/terms-of-service/

          If you haven't accepted the terms and you omit this
          option, you will be interactively prompted.
#>

# Get folder paramiters For Script
$LogFolder = Read-Host "`n`n`n`nSpecify log folder without quotes or trailing slash. `n(ie. C:\Tmp )`n"
$TargetFolder = Read-Host "`n`n`n`nSpecify target folder without quotes or trailing slash. `n(ie. C:\Tmp )`n"

# Get and check if the sigcheck.exe location is valid.
do{
    $SigCheckLocation = ""
    $SigCheckLocation = Read-Host "`n`n`n`nSpecify location of sigcheck.exe without quotes. `n(ie. C:\Tmp\sigcheck.exe )`n"
}
until($SigCheckLocation -match ".*(exe)")

# Check if this is a recursive search.
do{
    $Recursive = ""
    $Recursive = Read-Host "`n`n`n`nWill be a recursive (include sub-folders) search? [y/n]`n"
}
until($Recursive -eq "y" -or $Recursive -eq "n")

# Initialize Variable Paramiters
[string]$PCName = $env:COMPUTERNAME
[string]$TimeStamp = Get-Date -UFormat '%y%m%d-%H%M%S'
[string]$LogFile = "$LogFolder\Scan-WithVirusTotal-(YYMMDD-HHMMSS)-($TimeStamp)_Hostname($PCName)"+".csv"

# Start Recursive Search Process [CSV Output, Show Only Non-Zero, Executables Only, Recursive, Auto-Agree to VirusTotal Terms, Use VirusTotal]
if($Recursive -eq "y"){
    Start-Process $SigCheckLocation -Wait `
        -ArgumentList " -c -u -e -s -vt -v `"$TargetFolder`"" `
        -RedirectStandardOutput $LogFile
}

# Start Non-Recursive Search Process [CSV Output, Show Only Non-Zero, Executables Only, Auto-Agree to VirusTotal Terms, Use VirusTotal]
elseif($Recursive -eq "n"){
    Start-Process $SigCheckLocation -Wait `
        -ArgumentList " -c -u -e -vt -v `"$TargetFolder`"" `
        -RedirectStandardOutput $LogFile
}

# User hits "q" and wants to quit.
else{
    Write-Warning "Error in input."
}
