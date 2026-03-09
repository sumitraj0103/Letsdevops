@description('The name of the app used to derive resource names.')
param appName string

@description('Base name for the two function apps.')
param functName string

@description('Name of the storage account to create.')
param stgacctName string

@allowed(['Standard_LRS', 'Standard_GRS', 'Standard_RAGRS'])
param storageAccountType string = 'Standard_LRS'

@description('Name of the storage queue.')
param queueName string = 'autoscale'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Location for Application Insights.')
param appInsightsLocation string = resourceGroup().location

@allowed(['node', 'dotnet', 'java', 'powershell'])
@description('Language runtime for the scaler function app.')
param scalerRuntime string = 'powershell'

@allowed(['node', 'dotnet', 'dotnet-isolated', 'java', 'powershell'])
@description('Language runtime for the engine function app.')
param engineRuntime string = 'dotnet-isolated'

// Derived names
var functionAppNameScaler = '${functName}-scaler'
var functionAppNameEngine = '${functName}-engine'
var hostingPlanName = '${appName}-asp'
var applicationInsightsName = '${appName}-appinsights'
var appConfigName = '${appName}-appconfig'

// Storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: stgacctName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
}

// Queue service (child of storage account)
resource queueService 'Microsoft.Storage/storageAccounts/queueServices@2022-09-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

// Queue (child of queue service)
resource storageQueue 'Microsoft.Storage/storageAccounts/queueServices/queues@2022-09-01' = {
  parent: queueService
  name: queueName
  properties: {
    metadata: {}
  }
}

// Elastic Premium hosting plan
resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: 'EP1'
    tier: 'ElasticPremium'
  }
  properties: {
    maximumElasticWorkerCount: 20
    targetWorkerCount: 1
    targetWorkerSizeId: 3
  }
}

// Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: appInsightsLocation
  kind: 'web'
  tags: {
    'hidden-link:${resourceId('Microsoft.Web/sites', applicationInsightsName)}': 'Resource'
  }
  properties: {
    Application_Type: 'web'
    Request_Source: 'IbizaWebAppExtensionCreate'
  }
}

// App Configuration store
resource appConfig 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: appConfigName
  location: location
  sku: {
    name: 'standard'
  }
}

// App Config key values (children of App Config store)
resource appConfigKvStorageAccount 'Microsoft.AppConfiguration/configurationStores/keyValues@2023-03-01' = {
  parent: appConfig
  name: 'storageAccount'
  properties: {
    value: stgacctName
    contentType: 'string'
  }
}

resource appConfigKvStorageQueue 'Microsoft.AppConfiguration/configurationStores/keyValues@2023-03-01' = {
  parent: appConfig
  name: 'storageQueue'
  properties: {
    value: queueName
    contentType: 'string'
  }
}

resource appConfigKvDebugMode 'Microsoft.AppConfiguration/configurationStores/keyValues@2023-03-01' = {
  parent: appConfig
  name: 'debugMode'
  properties: {
    value: 'true'
    contentType: 'string'
  }
}

// Storage account connection string (computed once, used by both function apps)
var storageConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'

// Scaler Function App (PowerShell)
resource scalerFunctionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppNameScaler
  location: location
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      appSettings: [
        { name: 'AzureWebJobsStorage', value: storageConnectionString }
        { name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING', value: storageConnectionString }
        { name: 'WEBSITE_CONTENTSHARE', value: toLower(functionAppNameScaler) }
        { name: 'FUNCTIONS_EXTENSION_VERSION', value: '~4' }
        { name: 'APPINSIGHTS_INSTRUMENTATIONKEY', value: appInsights.properties.InstrumentationKey }
        { name: 'APPLICATIONINSIGHTS_CONNECTION_STRING', value: appInsights.properties.ConnectionString }
        { name: 'FUNCTIONS_WORKER_RUNTIME', value: scalerRuntime }
        { name: 'WEBSITE_RUN_FROM_PACKAGE', value: '1' }
        { name: 'AppConfigEndpoint', value: appConfig.properties.endpoint }
      ]
      use32BitWorkerProcess: false
      powerShellVersion: '7.4'
    }
  }
}

// Engine Function App (.NET)
resource engineFunctionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppNameEngine
  location: location
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: hostingPlan.id
    clientAffinityEnabled: true
    siteConfig: {
      appSettings: [
        { name: 'AzureWebJobsStorage', value: storageConnectionString }
        { name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING', value: storageConnectionString }
        { name: 'WEBSITE_CONTENTSHARE', value: toLower(functionAppNameEngine) }
        { name: 'FUNCTIONS_EXTENSION_VERSION', value: '~4' }
        { name: 'APPINSIGHTS_INSTRUMENTATIONKEY', value: appInsights.properties.InstrumentationKey }
        { name: 'APPLICATIONINSIGHTS_CONNECTION_STRING', value: appInsights.properties.ConnectionString }
        { name: 'FUNCTIONS_WORKER_RUNTIME', value: engineRuntime }
        { name: 'WEBSITE_RUN_FROM_PACKAGE', value: '1' }
        { name: 'AppConfigEndpoint', value: appConfig.properties.endpoint }
      ]
      use32BitWorkerProcess: false
    }
  }
}

// Outputs consumed by deploy.ps1
output scalerResourceId string = scalerFunctionApp.id
output engineResourceId string = engineFunctionApp.id
output appConfigResourceId string = appConfig.id
output stgAcctResourceId string = storageAccount.id
