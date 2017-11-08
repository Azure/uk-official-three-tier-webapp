[CmdletBinding()]
Param(
	[string]$SafeModePassword = "SafeModeP@ssw0rd",
	[string]$DomainName = "contoso.com",
	[string]$DomainNetbiosName = "CONTOSO"
)

$ErrorActionPreference = "Stop"

Initialize-Disk -Number 2 -PartitionStyle GPT
New-Partition -UseMaximumSize -DriveLetter F -DiskNumber 2
Format-Volume -DriveLetter F -Confirm:$false -FileSystem NTFS -force 

Install-windowsfeature -name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools

Import-Module ADDSDeployment

$secSafeModePassword = ConvertTo-SecureString $SafeModePassword -AsPlainText -Force

Install-ADDSForest `
-SafeModeAdministratorPassword $secSafeModePassword `
-CreateDnsDelegation:$false `
-DatabasePath "F:\Windows\NTDS" `
-DomainMode "Win2012R2" `
-DomainName $DomainName `
-DomainNetbiosName $DomainNetbiosName `
-ForestMode "Win2012R2" `
-InstallDns:$true `
-LogPath "F:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "F:\Windows\SYSVOL" `
-Force:$true
