# Purpose: Installs a handful of SysInternals tools on the host into c:\Tools\Sysinternals

$sysmonDir = "C:\ProgramData\Sysmon"
$sysinternalsDir = "C:\Tools\Sysinternals"
$sysmonConfigPath = "$sysmonDir\sysmonConfig.xml"
$sysmonPath = "C:\Tools\Sysinternals\Sysmon64.exe"

# Download Olaf Hartongs Sysmon config
# # Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Olaf Hartong's Sysmon config..."
# # (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/olafhartong/sysmon-modular/master/sysmonconfig.xml', "$sysmonConfigPath")
# # Alternative: Download SwiftOnSecurity's Sysmon config
Write-Host "Downloading SwiftOnSecurity's Sysmon config..."
# (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml', "$sysmonConfigPath")
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/z-AlphaVersion.xml', "$sysmonConfigPath")

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Checking if sysmon service exist and update config"
If (Get-Service Sysmon64 -ErrorAction SilentlyContinue) {
  Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Updating sysmon config from $sysmonConfigPath"
  Start-Process -FilePath "$sysmonDir\Sysmon64.exe" -ArgumentList "-accepteula -c $sysmonConfigPath"
  exit
}

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Installing SysInternals Tooling..."
If(!(test-path $sysinternalsDir)) {
  New-Item -ItemType Directory -Force -Path $sysinternalsDir
} Else {
  Write-Host "Tools directory exists. Exiting."
  exit
}

If(!(test-path $sysmonDir)) {
  New-Item -ItemType Directory -Force -Path $sysmonDir
} Else {
  Write-Host "Sysmon directory exists. Exiting."
  exit
}

$autorunsPath = "C:\Tools\Sysinternals\Autoruns64.exe"
$procmonPath = "C:\Tools\Sysinternals\Procmon.exe"
$psexecPath = "C:\Tools\Sysinternals\PsExec64.exe"
$procexpPath = "C:\Tools\Sysinternals\procexp64.exe"
$tcpviewPath = "C:\Tools\Sysinternals\Tcpview.exe"


# Microsoft likes TLSv1.2 as well
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Autoruns64.exe..."
(New-Object System.Net.WebClient).DownloadFile('https://live.sysinternals.com/Autoruns64.exe', $autorunsPath)
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Procmon.exe..."
(New-Object System.Net.WebClient).DownloadFile('https://live.sysinternals.com/Procmon.exe', $procmonPath)
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading PsExec64.exe..."
(New-Object System.Net.WebClient).DownloadFile('https://live.sysinternals.com/PsExec64.exe', $psexecPath)
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading procexp64.exe..."
(New-Object System.Net.WebClient).DownloadFile('https://live.sysinternals.com/procexp64.exe', $procexpPath)
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Sysmon64.exe..."
(New-Object System.Net.WebClient).DownloadFile('https://live.sysinternals.com/Sysmon64.exe', $sysmonPath)
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Tcpview.exe..."
(New-Object System.Net.WebClient).DownloadFile('https://live.sysinternals.com/Tcpview.exe', $tcpviewPath)
Copy-Item $sysmonPath $sysmonDir

# Download Olaf Hartongs Sysmon config
# Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Olaf Hartong's Sysmon config..."
# (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/olafhartong/sysmon-modular/master/sysmonconfig.xml', "$sysmonConfigPath")
# Alternative: Download SwiftOnSecurity's Sysmon config
Write-Host "Downloading SwiftOnSecurity's Sysmon config..."
#(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml', "$sysmonConfigPath")
(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/z-AlphaVersion.xml', "$sysmonConfigPath")

# Start Sysmon
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Starting Sysmon..."
# If Process exists update config
If (Get-Service Sysmon64 -ErrorAction SilentlyContinue) {
Start-Process -FilePath "$sysmonDir\Sysmon64.exe" -ArgumentList "-accepteula -c $sysmonConfigPath"
}
# If the Sysmon service does not exist install it
Else {
Start-Process -FilePath "$sysmonDir\Sysmon64.exe" -ArgumentList "-accepteula -i $sysmonConfigPath"
}
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Verifying that the Sysmon service is running..."
Start-Sleep 5 # Give the service time to start
If ((Get-Service -name Sysmon64).Status -ne "Running")
{
  throw "The Sysmon service did not start successfully"
}
