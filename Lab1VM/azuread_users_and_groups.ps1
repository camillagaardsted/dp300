
Connect-AzAccount

$pn=Get-AzDomain |select -expandproperty domains

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


##################### IT department ##########################

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

$upn | clip