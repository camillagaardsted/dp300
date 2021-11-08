# hele Azure modulet til at håndtere az ressourcer i powershell
Install-module AZ

Get-module Az* -ListAvailable

Connect-AzAccount 

Get-AzResourceGroup

$location='westeurope'
New-AzResourceGroup -Name sqlDevmiljø -Location $location

Get-AzResourceGroup

# vi kan oprette en ny Azure VM med denne cmdlet direkte
New-AzVM

# eller vi kan anvende en ARM (Azure resource manager) template -


$projectName = "vm"
$location = "westeurope"
$adminUsername = "dbadmin"
$adminPassword = ConvertTo-SecureString -AsPlainText "SuperUsers1234!" -Force
#$dnsLabelPrefix = "dp300"
$resourceGroupName = "${projectName}rg"

New-AzResourceGroup -Name $resourceGroupName -Location "$location"


New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -adminPassword $adminPassword -TemplateParameterUri https://raw.githubusercontent.com/camillagaardsted/dp300/main/Lab1VM/parameters.json -TemplateUri https://raw.githubusercontent.com/camillagaardsted/dp300/main/Lab1VM/template.json


## vi skal lave Azure AD brugere og grupper'



$tenantName = 'su20211108outlook'
$pn = "$tenantName.onmicrosoft.com"

Connect-AzAccount

Get-AzDomain

$password="Pa55w.rd"
$passwordSecure=ConvertTo-SecureString -AsPlainText $password -Force

$username="otto"
$Name="Otto Pilfinger"
$upn = "$username@$pn"
$mailnickname="ottoregnskab"
$otto=New-AzADUser -DisplayName $Name -UserPrincipalName $upn -Password $passwordSecure -MailNickname $mailnickname

$username="ottoline"
$Name="Ottoline Pilfinger"
$upn = "$username@$pn"
$mailnickname="ottolinemarketing"
$ottoline=New-AzADUser -DisplayName $Name -UserPrincipalName $upn -Password $passwordSecure -MailNickname $mailnickname



$groupName="BI group"
$mailnickname="bigruppen"
$bigroup=New-AzADGroup -DisplayName $groupName -MailNickname $mailnickname 

Add-AzADGroupMember -TargetGroupDisplayName $groupName -MemberUserPrincipalName $otto.UserPrincipalName,$ottoline.UserPrincipalName

#Get-AzADGroup | Remove-AzADGroup

# Opret to IT folk i Azure AD
$username="ivan"
$Name="Ivan IT"
$upn = "$username@$pn"
$mailnickname="ivanit"
$ivan=New-AzADUser -DisplayName $Name -UserPrincipalName $upn -Password $passwordSecure -MailNickname $mailnickname

$username="frode"
$Name="Frode Pilfinger"
$upn = "$username@$pn"
$mailnickname="frodeit"
$frode=New-AzADUser -DisplayName $Name -UserPrincipalName $upn -Password $passwordSecure -MailNickname $mailnickname

# Opret sikkerhedsgruppe til vores to IT folk
$groupName="IT group"
$mailnickname="itgruppen"
$bigroup=New-AzADGroup -DisplayName $groupName -MailNickname $mailnickname 

Add-AzADGroupMember -TargetGroupDisplayName $groupName -MemberUserPrincipalName $ivan.UserPrincipalName,$frode.UserPrincipalName


# Opret sikkerhedsgruppe til vores to IT folk
$groupName="DBA group"
$mailnickname="dbagruppen"
$dbagroup=New-AzADGroup -DisplayName $groupName -MailNickname $mailnickname 

Add-AzADGroupMember -TargetGroupDisplayName $groupName -MemberUserPrincipalName $upn

