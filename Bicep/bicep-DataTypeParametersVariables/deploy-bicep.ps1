# Set the variables
$resourceGroupName = "srsdemo"
$templateFilePath = "C:\TEMP\Letsdevops\bicep\bicep-ParametersVartiables\storageaccount.bicep"
$parametersFilePath = "C:\TEMP\Letsdevops\bicep\bicep-ParametersVartiables\storageaccount.parameters.json"
$deploymentName = "demodeploy"

# Authenticate to Azure
Connect-AzAccount

# Select the subscription (if necessary)
Set-AzContext -SubscriptionId "your-subscription-id"

# Deploy the Bicep template
New-AzResourceGroupDeployment `
  -DeploymentName $deploymentName `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFilePath `
  -TemplateParameterFile $parametersFilePath
