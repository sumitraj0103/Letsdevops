$resourceGroupName = "test"
$deploymentName = "your11"
$bicepFile = "path/to/your/template.bicep"
$parametersFile = "path/to/your/parameters.json"

# Log in to Azure using the Azure CLI
az login

# Set the active subscription
az account set --subscription "your-subscription-id"

# Create the resource group if it doesn't exist
#az group create --name $resourceGroupName --location "your-location"

# Deploy the Bicep file
az deployment group create --name $deploymentName `
                           --resource-group $resourceGroupName `
                           --template-file $bicepFile `
                           --parameters $parametersFile