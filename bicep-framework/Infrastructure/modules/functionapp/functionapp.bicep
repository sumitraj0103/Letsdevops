@description('Location for all resources')
param location string = resourceGroup().location

@description('Application name')
param appName string

@description('Environment (dev, test, staging, prod)')
param environment string

@description('Optional suffix for resource naming')
param suffix string = ''

@description('Function App runtime stack')
@allowed([
  'dotnet'
  'node'
  'python'
  'java'
])
param runtime string = 'dotnet'

@description('Function App runtime version')
param runtimeVersion string = '8'

@description('App Service Plan SKU')
@allowed([
  'Y1'
  'EP1'
  'EP2'
  'EP3'
  'P1V2'
  'P2V2'
  'P3V2'
])
param skuName string = 'Y1'

@description('Tags to apply to resources')
param tags object = {}

// Generate resource names using naming convention
var functionAppName = suffix != '' ? 'func-${appName}-${environment}-${suffix}' : 'func-${appName}-${environment}'
var appServicePlanName = suffix != '' ? 'asp-${appName}-${environment}-${suffix}' : 'asp-${appName}-${environment}'
var storageAccountName = suffix != '' ? 'st${appName}${environment}${suffix}' : 'st${appName}${environment}'
var applicationInsightsName = suffix != '' ? 'appi-${appName}-${environment}-${suffix}' : 'appi-${appName}-${environment}'

// Clean storage account name (remove hyphens, ensure min 3 chars)
var cleanStorageAccountName = length(replace(storageAccountName, '-', '')) < 3 ? 'sta${uniqueString(resourceGroup().id)}' : take(replace(storageAccountName, '-', ''), 24)

// Storage Account for Function App
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: cleanStorageAccountName
  location: location
  tags: tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

// Application Insights
resource applicationInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: applicationInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: skuName
  }
  properties: {
    reserved: true
  }
}

// Function App
resource functionApp 'Microsoft.Web/sites@2023-01-01' = {
  name: functionAppName
  location: location
  tags: tags
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${az.environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${az.environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(functionAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: runtime
        }
      ]
      linuxFxVersion: '${toUpper(runtime)}|${runtimeVersion}'
      alwaysOn: skuName != 'Y1' // Always on not available for consumption plan
    }
    httpsOnly: true
  }
}

output functionAppId string = functionApp.id
output functionAppName string = functionApp.name
output functionAppHostname string = functionApp.properties.defaultHostName
output storageAccountName string = storageAccount.name
output applicationInsightsName string = applicationInsights.name
