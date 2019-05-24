$DC = "8.8.8.8"
$Internet = "8.8.4.4"
$dns = "$DC", "$Internet"
Set-DnsClientServerAddress -InterfaceIndex 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 17, 18, 19, 20 -ServerAddresses ($DNS)
Enable-NetAdapter -Name 'Wi-Fi' -Confirm:$false
cd C:/"Program Files"/
rename "Microsoft Office2" "Microsoft Office"
sc start dhcp
Set-WinUserLanguageList -LanguageList en-US -Force
cd C:/
net share testfolder /DELETE
del testfolder /y
rmdir testfolder /y
Read-Host -Prompt "Press Enter to continue"
