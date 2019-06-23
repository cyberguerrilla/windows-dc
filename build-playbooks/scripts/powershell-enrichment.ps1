Get-ADComputer -filter * -Properties CN, OperatingSystem | ?{$_.operatingsystem -ne $null} | select @{Name="CN";e={$($_.CN).ToLower()}}, @{Name="OperatingSystem";e={$($_.OperatingSystem).Replace("®","")}} | convertto-csv -NoTypeInformation | select -skip 1 | Out-File C:\users\gwhite\comp-os.csv

Get-ADComputer -filter * -Properties CN, IPV4Address | ?{$_.IPV4Address -ne $null} | select @{Name="CN";e={$($_.CN).ToLower()}}, IPV4Address | convertto-csv -NoTypeInformation | select -skip 1 | Out-File C:\users\gwhite\comp-ip.csv

$table = @{ "Domain Controllers" = "Domain Controller"; "Exchange Servers" = "Exchange Server"; "VDI - All Base Apps" = "Virtual Desktop"}
#$table = @{ "Domain Controllers" = "Domain Controller" }

#https://adsecurity.org/?p=3719

#$Device_Types = "Domain Controllers", "Exchange Servers", "VDI - All Base Apps"

Remove-Item C:\users\gwhite\comp-type.csv

foreach ($Device_Type in $($table.GetEnumerator()))
{


Get-ADGroupMember "$($Device_Type.Name)" -Recursive | Get-ADComputer -Properties CN | select @{Name="CN";e={$($_.CN).ToLower()}}, @{Name="Device_Type";e={$($Device_Type.Value).TrimEnd("s")}} | convertto-csv -NoTypeInformation | select -skip 1 | Out-File C:\users\gwhite\comp-type.csv -Append

}
