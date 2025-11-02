param location string
param rgName string
param webAppName string
param acrLoginServer string
param imageName string
param containerTag string

resource plan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: '${webAppName}-plan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  kind: 'app'
}

resource app 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|${acrLoginServer}/${imageName}:${containerTag}'
    }
  }
}

output webAppUrl string = app.properties.defaultHostName
