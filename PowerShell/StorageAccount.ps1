# Create Storage account
New-AzStorageAccount -ResourceGroupName $resourcegroup `
  -Name 'lacknapptest1' `
  -Location $location `
  -SkuName Standard_LRS `
  -Kind StorageV2