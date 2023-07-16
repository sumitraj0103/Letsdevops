param location string = 'westus'
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'myStorageAccount'
  location: location
  kind: 'BlobStorage'
  sku: {
    name: 'Standard_LRS'
  }
}
resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'myWebApp'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
  dependsOn: [
    storageAccount
  ]
}
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'myAppServicePlan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
  }
}
