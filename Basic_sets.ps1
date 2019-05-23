function Color-Green{
    process { Write-Host $_ -ForegroundColor Green }
}
function Color-Red{
    process { Write-Host $_ -ForegroundColor Red }
}
function Color-Yellow{
    process { Write-Host $_ -ForegroundColor Yellow }
}

function add_dns_record{
    Write-Host =  
    $zone = $args[0]
    Add-DnsServerPrimaryZone -Name $zone -ReplicationScope Forest -Confirm -PassThru
    Add-DnsServerResourceRecordA -Name $zone -ComputerName 127.0.0.1 -ZoneName $zone -AllowUpdateAny -IPv4Address 127.0.0.1
}


function path_exist_create{
    $path = $args[0]
    if(![System.IO.File]::Exists($path)){
        New-Item -Path $args[0] -Name $args[1] -ItemType "directory" 
    }
}

function start_iis_site_configuration {
    $BindingInformation = "*:80"
    $PhysicalPathRoot = "C:\inetpub\wwwroot\"
    $PhysicalPath = $PhysicalPathRoot + $args[0]
    $Name = $args[0]
    path_exist_create $PhysicalPathRoot $args[0]
    New-IISSite -BindingInformation $BindingInformation -PhysicalPath $PhysicalPath -Name $Name
    add_dns_record $args[0]
}

<#

Verify if is the input is a domin ny containing a . in it

#>
function verifiy_is_domain{
do
{
$new_site = Read-Host "Enter new IIS domain > "
}
until ($new_site -like '*.*')
return $new_site
}

function confirm_iis_site_creation {
    $confirmation= Read-Host "do you wish to go through with those configuration (y/n) >"
    Switch ($confirmation){
        'y' {
            Write-Host Creating the following configration for domain $args[0]
            start_iis_site_configuration $args[0]
        }
        '*'{
            Write-Host The following configuration will not be created for domain $args[0]
        }
    }
}

function get_iis_sites
{
    Write-Output '============ List of all iis Sites =============='
    Get-IISSite
}

function create_an_iis_site{
    param ( 
           [string]$Site = 'New ISS Site',
           [string]$PhyPath = 'C:\inetpub\wwwroot\'
    )
    Write-Output "============= $Site  ================" | Color-Yellow
    $new_site = verifiy_is_domain
    Write-Host Creating a new site with name $new_site
    Write-Host With Physical path $PhyPath$new_site
    Write-Host And Binding at $new_site':'80
    confirm_iis_site_creation  $new_site
}

function Main-Menu {
     param ( 
           [string]$Title = 'Adam Admin Menu',
           [string]$current_date = (Get-Date).ToUniversalTime()
     )
     cls
     Write-Output "============= $Title $current_date ================" 
     Write-Output "1: Press '1' To install a new services." | Color-Green
     Write-Output "2: Press '2' To Select a server" | Color-Green
     Write-Output "3: Press '3' To Create a new iis site" | Color-Green
     Write-Output "4: Press '4' List All IIS Sites" | Color-Green
     Write-Output "Q: Press 'Q' To Quit" | Color-Red
}

function askfeature {
    $feature = Get-WindowsFeature | select -Property Displayname,Name,installstate | Out-GridView -OutputMode Single
    Write-Host Installing $feature.Name
    Install-WindowsFeature -Name $feature.Name -IncludeAllSubFeature -Confirm:$false -IncludeManagementTools
}

function get_ad_server{
    $server_selected = get-adcomputer -filter {OperatingSystem -Like "Windows Server*"} -Property OperatingSystem,Name  | select -Property OperatingSystem,Name   | Out-GridView -OutputMode Single
    Write-Host Selecting $server_selected.Name
}

do 
{ 
     Main-Menu
     $input = Read-Host "Please make a selection" 
     switch ($input) 
     { 
           '1' { 
                askfeature
           }
           '2' { 
                get_ad_server
           }
           '3' { 
                create_an_iis_site
           }
           '4'{
            get_iis_sites
           } 
            'q' { 
                return 
           } 
     } 
     pause 
} 
until ($input -eq 'q') 