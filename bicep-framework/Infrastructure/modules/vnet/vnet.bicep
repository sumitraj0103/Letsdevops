@description('Location for all resources')
param location string = resourceGroup().location

@description('Application name')
param appName string

@description('Environment (dev, test, staging, prod)')
param environment string

@description('Optional suffix for resource naming')
param suffix string = ''

@description('Virtual Network address prefix')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Subnet configurations')
param subnets array = [
  {
    name: 'default'
    addressPrefix: '10.0.1.0/24'
  }
]

@description('Tags to apply to resources')
param tags object = {}

// Generate resource name using naming convention
var vnetName = suffix != '' ? '${appName}-${environment}-${suffix}' : '${appName}-${environment}'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
      }
    }]
  }
}

output vnetId string = virtualNetwork.id
output vnetName string = virtualNetwork.name
output subnetIds array = [for (subnet, i) in subnets: {
  name: subnet.name
  id: virtualNetwork.properties.subnets[i].id
}]
