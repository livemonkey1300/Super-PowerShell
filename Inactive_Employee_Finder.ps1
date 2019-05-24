$domain = Get-ADDOMAIN
#OU can be specified

$DaysInactive = 120
$time = (Get-Date).Adddays(-($DaysInactive))

#This Reqired an OU to target inside the active directory
$baseOU = ""
$msiOUdate = Get-ADUser -SearchBase $baseOU -Filter {LastLogonTimeStamp -lt $time -and enabled -eq $true} -Properties LastLogonTimeStamp


# Get all AD User with lastLogonTimestamp less than our time and set to enable
#$delusers = Get-ADUser -Filter {LastLogonTimeStamp -lt $time -and enabled -eq $true} -Properties LastLogonTimeStamp
foreach ($User in $msiOUdate ) {
Get-ADUser $User
}


pause 