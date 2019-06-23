New-Item -ItemType Directory -Force -Path "C:\DNSLogs"
Set-DnsServerDiagnostics -FullPackets $True -SendPackets $True -TcpPackets $True -Answers $True `
-Updates $True -UdpPackets $True -ReceivePackets $True -Queries $True -QuestionTransactions $True `
-EnableLogFileRollover $True -EnableLoggingToFile $True -LogFilePath "C:\DNSLogs\dns.log" `
-MaxMBFileSize 500000000
Start-Sleep -Seconds 5
Restart-Service DNS
