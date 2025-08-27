@description('Location for all resources')
param location string = resourceGroup().location

@description('Application name')
param appName string = 'appx0103'

@description('Environment (dev, test, staging, prod)')
param environment string = 'dev'

@description('Optional suffix for resource naming')
param suffix string = ''

@description('Tags to apply to resources')
param tags object = {
  Environment: environment
  Application: appName
  CostCenter: 'IT'
}

// Deploy Virtual Network
module vnet '../../modules/vnet/vnet.bicep' = {
  name: 'vnet-deployment'
  params: {
    location: location
    appName: appName
    environment: environment
    suffix: suffix
    vnetAddressPrefix: '10.0.0.0/16'
    subnets: [
      {
        name: 'default'
        addressPrefix: '10.0.1.0/24'
      }
      {
        name: 'functions'
        addressPrefix: '10.0.2.0/24'
      }
    ]
    tags: tags
  }
}

// Deploy Network Security Group
module nsg '../../modules/nsg/nsg.bicep' = {
  name: 'nsg-deployment'
  params: {
    location: location
    appName: appName
    environment: environment
    suffix: suffix
    securityRules: [
      {
        name: 'AllowHTTPS'
        priority: 1000
        direction: 'Inbound'
        access: 'Allow'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '443'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
      }
      {
        name: 'AllowHTTP'
        priority: 1010
        direction: 'Inbound'
        access: 'Allow'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '80'
        sourceAddressPrefix: '*'
        destinationAddressPrefix: '*'
      }
      {
        name: 'AllowAPIM'
        priority: 1020
        direction: 'Inbound'
        access: 'Allow'
        protocol: 'Tcp'
        sourcePortRange: '*'
        destinationPortRange: '3443'
        sourceAddressPrefix: 'ApiManagement'
        destinationAddressPrefix: 'VirtualNetwork'
      }
    ]
    tags: tags
  }
}

// Deploy Function App
module functionApp '../../modules/functionapp/functionapp.bicep' = {
  name: 'functionapp-deployment'
  params: {
    location: location
    appName: appName
    environment: environment
    suffix: suffix
    runtime: 'dotnet'
    runtimeVersion: '8'
    skuName: 'Y1'
    tags: tags
  }
}


// Outputs
output vnetId string = vnet.outputs.vnetId
output vnetName string = vnet.outputs.vnetName
output nsgId string = nsg.outputs.nsgId
output functionAppName string = functionApp.outputs.functionAppName
output functionAppHostname string = functionApp.outputs.functionAppHostname
