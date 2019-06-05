cd "C:\ProgramData\chocolatey\lib\winlogbeat\tools"
#.\winlogbeat.exe export template --es.version 7.0.0 | Out-File -Encoding UTF8 winlogbeat.template.json
Invoke-RestMethod -Method Put -ContentType "application/json" -InFile C:\temp\scripts\winlogbeat.template.json -Uri http://172.16.58.211:9200/_template/winlogbeat
