$SplunkDir = "c:\tools\splunk"
If (!(Get-Service SplunkForwarder -ErrorAction SilentlyContinue)) {
  New-Item -ItemType Directory -Force -Path $SplunkDir
} Else {
  Write-Host "Splunk service exists. Exiting."
  exit
}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
(New-Object System.Net.WebClient).DownloadFile('https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=7.2.6&product=universalforwarder&filename=splunkforwarder-7.2.6-c0bf0f679ce9-x64-release.msi&wget=true', 'c:\tools\splunk\splunkforwarder-7.2.6-c0bf0f679ce9-x64-release.msi')
Start-Process c:\tools\splunk\splunkforwarder-7.2.6-c0bf0f679ce9-x64-release.msi `
    -Wait -Verbose -ArgumentList (`
        "AGREETOLICENSE=Yes", `
        "WINEVENTLOG_SEC_ENABLE=1", `
        "/l*v C:\TEMP\SplunkInstall.log", `
        "/quiet")

While ($(get-service -name SplunkForwarder).status -ne "Running") {
  Start-Sleep -Seconds 1  
}

#wget -O splunkforwarder-7.2.6-c0bf0f679ce9-x64-release.msi 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=7.2.6&product=universalforwarder&filename=splunkforwarder-7.2.6-c0bf0f679ce9-x64-release.msi&wget=true'
