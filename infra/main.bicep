param environment string = 'dev'
param location string = 'East US'
param rgName string
param acrName string
param webAppName string
param imageName string
param containerTag string = 'latest'

@description('Deploy resource group')
module rg './modules/resource-group.bicep' = {
  name: 'rg-${environment}'
  params: {
    rgName: rgName
    location: location
  }
}

@description('Deploy container registry')
module acr './modules/acr.bicep' = {
  name: 'acr-${environment}'
  params: {
    location: location
    acrName: acrName
  }
}

@description('Deploy web app container')
module web './modules/webapp.bicep' = {
  name: 'web-${environment}'
  params: {
    location: location
    rgName: rgName
    webAppName: webAppName
    acrLoginServer: acr.outputs.acrLoginServer
    imageName: imageName
    containerTag: containerTag
  }
}
