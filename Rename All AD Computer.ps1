Import-Module activedirectory

$computers = Get-ADComputer -Filter {OperatingSystem -NotLike "*server*"}

$credential = Get-Credential
foreach ( $computer in $computers ) {


$current = $computer.Name
$PingStatus = Gwmi Win32_PingStatus -Filter "Address = '$current'" |
Select-Object StatusCode
If ($PingStatus.StatusCode -eq 0)
{
if ( $GetWMIObject = Get-WMIObject Win32_ComputerSystem -Computername $current )
{

$UserName = $GetWMIObject.UserName.Split('\')[1]
$IPaddr = $GetWMIObject.Win32_NetworkAdapterConfiguration
Write-Host "#################################################"
Write-Host                                              
Write-Host "    Machine Name            Logged In User"
Write-Host                                                
Write-Host "   "$current"           "$Username-PC
Write-Host                                                
Write-Host "#################################################"
$confirmation = Read-Host "Are you Sure You Want To Proceed:"

if ($confirmation -eq 'y') {
Get-WmiObject Win32_ComputerSystem -ComputerName $current -Authentication 6 |
ForEach-Object {$_.Rename("$Username-PC", "Supp0rtt34m", "admin")}
Get-WmiObject Win32_OperatingSystem -ComputerName $current |
ForEach-Object {$_.Win32Shutdown(6)}
}

}
}
Else
{
#Write-Host $current -Fore "Red"
} 

}

Read-Host "Press ENTER"
