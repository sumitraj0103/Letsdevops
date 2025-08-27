@description('Location for all resources')
param location string = resourceGroup().location

@description('Application name')
param appName string

@description('Environment (dev, test, staging, prod)')
param environment string

@description('Optional suffix for resource naming')
param suffix string = ''

@description('Security rules for the NSG')
param securityRules array = [
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
]

@description('Tags to apply to resources')
param tags object = {}

// Generate resource name using naming convention
var nsgName = suffix != '' ? 'nsg-${appName}-${environment}-${suffix}' : 'nsg-${appName}-${environment}'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  tags: tags
  properties: {
    securityRules: [for rule in securityRules: {
      name: rule.name
      properties: {
        priority: rule.priority
        direction: rule.direction
        access: rule.access
        protocol: rule.protocol
        sourcePortRange: rule.sourcePortRange
        destinationPortRange: rule.destinationPortRange
        sourceAddressPrefix: rule.sourceAddressPrefix
        destinationAddressPrefix: rule.destinationAddressPrefix
      }
    }]
  }
}

output nsgId string = networkSecurityGroup.id
output nsgName string = networkSecurityGroup.name
