$DC = "204.13.250.44"
$Internet = "208.78.70.44"
$dns = "$DC", "$Internet"
Set-DnsClientServerAddress -InterfaceIndex 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 17, 18, 19, 20 -ServerAddresses ($DNS)
Disable-NetAdapter -Name 'Wi-Fi' -Confirm:$false
cd C:/"Program Files"/
rename "Microsoft Office" "Microsoft Office2"
sc stop dhcp
Set-WinUserLanguageList -LanguageList fr-CA -Force
cd C:/
mkdir testfolder
net share testfolder=C:\testfolder
Read-Host -Prompt "Press Enter to continue"
