param stname string = 'stdemo0103'
param location string = 'East US'
resource stdemo 'Microsoft.Storage/storageAccounts@2022-09-01' ={
  name: stname
  kind: 'BlobStorage'
  location: location
  sku: {
    name: 'Standard_LRS'

  }
  properties:{
    accessTier: 'Cool'
  }

}
