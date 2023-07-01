param staccount1 string = 'staccount0103'
param location string = 'East US'
resource staccount 'Microsoft.Storage/storageAccounts@2022-09-01'={
  name: staccount1
  kind: 'BlobStorage'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties:{
    accessTier: 'Cool'
  }
}
