param webappdemoname string = 'srsdemowebapp'
param aspdemoname string = 'srsdemoasp'
param location string = 'EastUS'

// referece Exisitng resource in same Scope
resource aspdemo 'Microsoft.Web/serverfarms@2022-09-01' existing ={
  name: aspdemoname
}

// referece Exisitng resource in different Scope
// resource aspdemoscope 'Microsoft.Web/serverfarms@2022-09-01' existing ={
//   name: aspdemoname
//   scope: resourceGroup('srstesdemo')
// }

resource webApp 'Microsoft.Web/sites@2020-12-01' = {
  name: webappdemoname
  location: location
  properties: {
    //using the existing reference id 
    serverFarmId: aspdemo.id
  }
}
