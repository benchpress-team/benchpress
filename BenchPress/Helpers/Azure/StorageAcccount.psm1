function Get-StorageAccountExists([string]$resourceGroupName, [string]$storageAccountName){
  $resource = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName

  return ($null -ne $resource)
}

function Get-StorageAccountKind([string]$resourceGroupName, [string]$storageAccountName) {
  $resource = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName

  return $resource.Kind
}

function Get-StorageAccountSku([string]$resourceGroupName, [string]$storageAccountName) {
  $resource = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName


  return $resource.Sku.Name
}

function Get-StorageAccountDNS([string]$resourceGroupName, [string]$storageAccountName) {
  $resource = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName

  return $resource.PrimaryEndpoints.Blob
}

Export-ModuleMember -Function `
  Get-StorageAccountExists, Get-StorageAccountKind, Get-StorageAccountSku, Get-StorageAccountDNS