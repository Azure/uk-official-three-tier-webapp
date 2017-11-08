[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True)]
  [string]$AdminUser,

  [Parameter(Mandatory=$True)]
  [string]$AdminPassword,

  [Parameter(Mandatory=$True)]
  [string]$SafeModePassword,

  [Parameter(Mandatory=$True)]
  [string]$DomainName,

  [Parameter(Mandatory=$True)]
  [string]$SiteName

)

Initialize-Disk -Number 2 -PartitionStyle GPT
New-Partition -UseMaximumSize -DriveLetter F -DiskNumber 2
Format-Volume -DriveLetter F -Confirm:$false -FileSystem NTFS -force 

$secSafeModePassword = ConvertTo-SecureString $SafeModePassword -AsPlainText -Force
$secAdminPassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ("$DomainName\$AdminUser", $secAdminPassword)

Install-windowsfeature -name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools

Import-Module ADDSDeployment

Install-ADDSDomainController `
-Credential $credential `
-SafeModeAdministratorPassword $secSafeModePassword `
-DomainName $DomainName `
-SiteName $SiteName `
-SysvolPath "F:\Adds\SYSVOL" `
-DatabasePath "F:\Adds\NTDS" `
-LogPath "F:\Adds\NTDS" `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$false `
-CriticalReplicationOnly:$false `
-InstallDns:$true `
-NoRebootOnCompletion:$false `
-Force:$true