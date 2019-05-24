
Function Update-ADUsers {
Import-Csv "C:\User_test.csv" | ForEach-Object { 

$City = $_.'City'
$StreetAddress = $_.'Full address'
$State = $_.State
$PostCode = $_.'Post Code' 
$Country = $_.'Country' 
$Title = $_.'Job Title'
$Phone = $_.'Phone'

Try { $account = Get-ADUser -Filter "EmailAddress -eq '$($_.email)'" -properties * } 
Catch { }
 If( $account -ne $null )
    {	

IF ($Title -ne '' ) { Set-ADUser -Identity $account -Replace @{Title=$Title} }
IF ($Phone -ne '' ) { Set-ADUser -Identity $account -Replace @{telephoneNumber=$Phone}  }
IF ($StreetAddress -ne '' ) { Set-ADUser -Identity $account -Replace @{StreetAddress=$StreetAddress} }
IF ($City -ne '' ) { Set-ADUser -Identity $account -Replace @{l=$City} }
IF ($State -ne '') { Set-ADUser -Identity $account -State $State } 
IF ($PostCode -ne '') { Set-ADUser -Identity $account -Replace @{postalCode=$PostCode} }
}

}
}

Update-ADUsers

Read-Host 'Press Enter to continue…'
