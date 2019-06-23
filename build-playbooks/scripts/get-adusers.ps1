Import-Module activedirectory
Get-ADUser -filter * -Properties City,CN,Created,Description,DisplayName,DistinguishedName,EmailAddress,Enabled,GivenName,LastBadPasswordAttempt,LastLogonDate,Manager,MemberOf,Modified,Name,Office,PasswordExpired,PasswordLastSet,PasswordNeverExpires,PasswordNotrequired,PrimaryGroup,Samaccountname,objectSID, SIDHistory,Surname,Title,ServicePrincipalNames `
| select City,CN,@{N="Created";e={$(get-date -Format s $_.Created)}},Description,DisplayName,DistinguishedName,EmailAddress,Enabled,GivenName,@{N="LastBadPasswordAttempt";e={$(get-date -Format s $_.LastBadPasswordAttempt)}},@{N="LastLogonDate";e={$(get-date -Format s $_.LastLogonDate)}},Manager,MemberOf,@{N="Modified";e={$(get-date -Format s $_.Modified)}},Name,Office,PasswordExpired,@{N="PasswordLastSet";e={$(get-date -Format s $_.PasswordLastSet)}},PasswordNeverExpires,PasswordNotrequired,PrimaryGroup,Samaccountname,@{N="SID";e={$_.objectsid.value}}, SIDHistory,Surname,Title,ServicePrincipalNames `
| %{Convertto-json -compress $_} | write-output
