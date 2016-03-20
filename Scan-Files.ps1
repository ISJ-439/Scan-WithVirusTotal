<#
usage: C:\Scan-Files\sigcheck.exe [-a][-h][-i][-e][-l][-n][[-s]|[-c|-ct]|[-m]][-q][-r][-u][-vt][-v[r][s]][-f catalog file] <file or directory>
usage: C:\Scan-Files\sigcheck.exe [-d][-c|-ct] <file or directory>
usage: C:\Scan-Files\sigcheck.exe [-t[u]] <certificate store name|*>
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

# Paramiters For Script
$NetworkDumpDir = 'Z:'

# Initialize Variable Paramiters\
[string]$PCName = $env:COMPUTERNAME
[string]$TimeStamp = Get-Date -UFormat '%y%m%d-%H%M%S'
[string]$LogFile = "$NetworkDumpDir\Scan-Files-Results-(YYMMDD-HHMMSS)-($TimeStamp)_For($PCName)"+".csv"

# Start Process
Start-Process "C:\Scan-Files\sigcheck.exe" -Wait -ArgumentList " -c -u -e -s -vt -v `"C:\`"" -RedirectStandardOutput $LogFile