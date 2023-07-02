
@description('Storage account with minimun 3 character and Max 24 Character')
@minLength(3)
@maxLength(24)
@secure()
param stname string //= 'stdemo01031'

var storageName = '${toLower(stname)}${uniqueString(resourceGroup().id)}'

@description('Allowed region where storage account needs to be created')
@allowed([

  'North Europe'
  'West Europe'
])
param stlocation string //= 'North Europe'

@description('Storage Account needs to be created under the allowed sku')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param stsku string //= 'Standard_LRS'

// Create Object Param
@description('Storage Account Property')
param stproperties object

resource stdemo 'Microsoft.Storage/storageAccounts@2022-09-01' ={
  name: storageName
  kind: 'BlobStorage'
  location: stlocation
  sku: {
    name: stsku

  }
  properties: stproperties
  // properties:{
  //   accessTier: stproperties.accessTier
  //   allowBlobPublicAccess: stproperties.allowBlobPublicAccess
  // }

}
output stoutput string = storageName
