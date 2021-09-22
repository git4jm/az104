
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'jmtmp3451sdfs'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
