<#
$postParams = Get-Date | Select-Object -Property * | ConvertTo-Json
$myFQDN=(Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain
Write-Host $myFQDN
Get-Service -DisplayName D* | Where-Object {$_.status -eq "Running"}
Invoke-WebRequest -UseBasicParsing http://portal.dnsnetworks.ca/reciver.php -ContentType "application/json" -Method POST -Body $postParams
#>
Function Get-NetworkRange {
   Param (
      [String]$IP,
      [String]$Mask
   )
   If ($IP.Contains("/"))
   {  $Temp = $IP.Split("/")
      $IP = $Temp[0]
      $Mask = $Temp[1]
   }
 
   If (!$Mask.Contains("."))
   {  $Mask = ConvertTo-Mask $Mask
   }
 
   $DecimalIP = ConvertTo-DecimalIP $IP
   $DecimalMask = ConvertTo-DecimalIP $Mask
 
   $Network = $DecimalIP -BAnd $DecimalMask
   $Broadcast = $DecimalIP -BOr ((-BNot $DecimalMask) -BAnd [UInt32]::MaxValue)
 
   For ($i = $($Network + 1); $i -lt $Broadcast; $i++)
   {  ConvertTo-DottedDecimalIP $i
   }
}  #End Get-NetworkRange


$GetComputerInfo = {
   Param (
      [string]$IP
   )
 
Function PrepSize
   {  Param (
         [double]$Size
      )
If ($Size -ge 1000000000)
{  $ReturnSize = "{0:N2} GB" -f ($Size / 1GB)
   }
   Else
{  $ReturnSize = "{0:N2} MB" -f ($Size / 1MB)
   }
Return $ReturnSize
}
 
#Reverse Ping to get DNS name (if exists)
$Ping = Get-WMIObject Win32_PingStatus -Filter "Address = '$IP' AND ResolveAddressNames = TRUE"
If ($Ping.StatusCode -eq 0)
{   $ComputerName = $Ping.ProtocolAddressResolved }
 
New-Object PSObject -Property @{
'Computer Name' = $ComputerName
Status = $Status
IP = $IP
OS = $OS
'OS Version' = $OSVersion
'OS Service Pack' = $ServicePack
CPU = $CPU
'Number of CPUs' = $NumCPUS
'Make/Model' = $MakeModel
'Service Tag' = $ServiceTag
'Serial Number' = $SerialNumber
Memory = $Memory
   'Hard Drives' = $Drives
}

#Get IP Address and Subnetmask if not specified in Parameters
$IPInfo = @(Get-WMIObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled='TRUE'")
If (-not $Network)
{  $Network = $IPInfo[0].IPAddress
}
If (-not $SubnetMask)
{  $SubnetMask = $IPInfo[0].IPSubnet
}
 
#Calculate IP range and submit GetComputerInfo scriptblock as background jobs
$Range = Get-NetworkRange $Network $SubnetMask


