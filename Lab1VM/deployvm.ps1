
Connect-AzAccount
$projectName = "vm"
$location = "westeurope"
$adminUsername = "dbadmin"
$adminPassword = ConvertTo-SecureString -AsPlainText "DummyPassword1234!" -Force
$dnsLabelPrefix = "dp300"
$resourceGroupName = "${projectName}rg"

New-AzResourceGroup -Name $resourceGroupName -Location "$location"

mkdir c:\DP300Kursus

cd c:\DP300Kursus

Invoke-WebRequest -Uri https://raw.githubusercontent.com/camillagaardsted/dp300/main/Lab1VM/parameters.json  -OutFile parameters.json
Invoke-WebRequest -Uri https://raw.githubusercontent.com/camillagaardsted/dp300/main/Lab1VM/template.json  -OutFile template.json

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateParameterFile parameters.json -TemplateFile template.json -adminPassword $adminPassword

# This line fails - if I try to deploy directly with the two files from GitHub
# error says The value of deployment parameter 'adminPassword' is null
#New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -adminPassword $adminPassword -TemplateParameterUri https://raw.githubusercontent.com/camillagaardsted/dp300/main/Lab1VM/parameters.json -TemplateUri https://raw.githubusercontent.com/camillagaardsted/dp300/main/Lab1VM/template.json

