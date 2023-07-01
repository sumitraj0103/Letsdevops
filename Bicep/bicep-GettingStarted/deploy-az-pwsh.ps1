# Set the variables
$resourceGroupName = "srsdemo"
$templateFilePath = "path/to/your/template.bicep"
$parametersFilePath = "path/to/your/parameters.json"
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