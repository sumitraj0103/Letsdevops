param location string = 'westus'
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'myAppServicePlan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
  }
}

resource webApp 'Microsoft.Web/sites@2020-12-01' = {
  name: 'myWebApp'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}
