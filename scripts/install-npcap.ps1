# Purpose: Installs npcap

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Installing Npcap"
$NpcapDir = "C:\ProgramData\Npcap"
$NpcapVersion = "0.994"
$NpcapFile = "$NpcapDir\" + 'npcap-' + $NpcapVersion + '.exe'
$NpcapUrl = "https://nmap.org/npcap/dist/" + 'npcap-' + $NpcapVersion + '.exe'

#If(!(test-path $NpcapDir)) {
#  New-Item -ItemType Directory -Force -Path $NpcapDir
#} Else {
#  Write-Host "Npcap directory exists. Exiting."
#  exit
#}

# Microsoft likes TLSv1.2 as well
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Downloading Npcap"

(New-Object System.Net.WebClient).DownloadFile($NpcapUrl, $NpcapFile)

# Install Npcap
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Installing Npcap..."
Start-Process -FilePath "$NpcapDir\npcap-$NpcapVersion.exe" -ArgumentList "/winpcap_mode=yes"

$InstallLogs = "C:\Program Files\Npcap\install.log"
$DriveInstallLog = "C:\Program Files\Npcap\NPFInstall.log"

#If ((Get-Service -name Sysmon64).Status -ne "Running")
#{
#  throw "The Sysmon service did not start successfully"
#}
